# Script to setup a fully configured pipeline

# Ensure Heroku and SFDX CLI is update
heroku update
sfdx update

# Create a unique var to append
TICKS=$(echo $(date +%s | cut -b1-13))

# Declare values
HEROKU_TEAM_NAME="appcloud-dev"
HEROKU_STAGING_APP_NAME="staging$TICKS"
HEROKU_PROD_APP_NAME="prod$TICKS"
HEROKU_PIPELINE_NAME="pipeline$TICKS"
GIT_REMOTE="https://github.com/wadewegner/salesforce-dx-pipeline-sample"

# Create Heroku apps
heroku apps:create $HEROKU_STAGING_APP_NAME -t $HEROKU_TEAM_NAME
heroku apps:create $HEROKU_PROD_APP_NAME -t $HEROKU_TEAM_NAME

# Create Pipeline
heroku pipelines:create $HEROKU_PIPELINE_NAME -a $HEROKU_STAGING_APP_NAME -s staging -t $HEROKU_TEAM_NAME

# Clean up
heroku pipelines:destroy $HEROKU_PIPELINE_NAME
heroku apps:destroy -a $HEROKU_STAGING_APP_NAME -c $HEROKU_STAGING_APP_NAME
heroku apps:destroy -a $HEROKU_PROD_APP_NAME -c $HEROKU_PROD_APP_NAME