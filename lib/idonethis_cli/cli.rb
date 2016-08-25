require 'oauth2'
require 'idonethis_cli/command'
require 'idonethis_cli/team'
require 'idonethis_cli/entry'

module IdonethisCli

  class Cli < Command
    desc "team COMMANDS", "Team commands"
    subcommand "team", IdonethisCli::Team

    desc "entry COMMANDS", "Entry commands"
    subcommand "entry", IdonethisCli::Entry

    # TODO not sure how to separate this out as a class like the subcommands to
    # Obviously could have subcommands for user like idt user login annd idt user logout
    desc "authorize", "you will be prompted to authorize with your I Done This credentials"
    def authorize
      url = auth_client.url
      code = cli.ask ("Enter code from this URL:\n #{url}").chomp.strip

      oauth2_token = auth_client.oauth2_token(code)

      if oauth2_token
        settings.save_oauth2_token(oauth2_token.to_hash)
        cli.say "Login successful"
      else
        cli.say "Login failed #{oauth2_token.error}"
      end
    end
  end
end
