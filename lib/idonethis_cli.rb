require "idonethis_cli/version"
require "idonethis_cli/cli"

# Can override:
# IDONETHIS_CLIENT_ID      (from oauth/applications)
# IDONETHIS_CLIENT_SECRET
# IDONETHIS_URL (e.g. https://beta.idonethis.com)
module IdonethisCli
  CLIENT_ID     = ENV['IDONETHIS_CLIENT_ID']     || 
    "bb73ffdf5672cd968bc6794d7b43b71d610695eb39c752da08a5b006af0920d4"
  CLIENT_SECRET = ENV['IDONETHIS_CLIENT_SECRET'] || 
    "86750e6ccaab1e88eec1cc51c2d81fb9ab3e9506532ea09dce077fa4dc5dbb90"
  BASE_URL = ENV['IDONETHIS_URL'] || 'https://beta.idonethis.com/'
  API_PATH = 'api/v2'
end
