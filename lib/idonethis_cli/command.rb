require 'thor'
require "idonethis_cli/settings"
require "idonethis_cli/client/auth"
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

    def auth_client
      @auth_client ||= IdonethisCli::Client::Auth.new
    end

    # This token is used to access things
    def token
      auth_client.token(settings.oauth2_token).tap do |token|
        settings.save_oauth2_token(token.to_hash)
      end
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
        cli.say("You have not set a team. Please run 'idt team set'")
        false
      end
    end
  end

end
