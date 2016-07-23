require 'thor'
require "idonethis_cli/settings"
require 'highline'

module IdonethisCli
  class Command < Thor

    private

    def cli
      @cli ||= HighLine.new
    end

    def settings
      @settings ||= Settings.new
    end

    # Oauth2 Client
    def oauth2_client 
      OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, site: BASE_URL)
    end

    # This token is used to access things
    def token
      OAuth2::AccessToken.from_hash(oauth2_client, settings.oauth2_token)
    end

    def authenticated?
      if settings.oauth2_token
        true
      else
        cli.say("You are not authenticated. Please run 'idt authorize'")
        false
      end
    end

    def team_set?
      if settings.team
        true
      else
        cli.say("You have not set a team. Please run 'idt team_set'")
        false
      end
    end
  end

end
