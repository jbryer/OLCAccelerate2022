# Adapted from
# https://stackoverflow.com/questions/63535190/connect-to-googlesheets-via-shiny-in-r-with-googlesheets4
# This script will setup a .secrets directory with permissions to access
# Google Sheets. If deploying the Shiny app to a server you will need to copy
# the .secrets folder with the app.

library(googlesheets4)

path <- dirname(rstudioapi::getSourceEditorContext()$path)
secrets_path <- paste0(path, "/.secrets")

# Set authentication token to be stored in a folder called `.secrets`
options(gargle_oauth_cache = secrets_path)

# Authenticate manually
googlesheets4::gs4_auth()

# If successful, the previous step stores a token file.
# Check that a file has been created with:
list.files(secrets_path)

# Check that the non-interactive authentication works by first deauthorizing:
gs4_deauth()

# Authenticate using token. If no browser opens, the authentication works.
gs4_auth(cache = secrets_path, email = "jason.bryer@gmail.com")

