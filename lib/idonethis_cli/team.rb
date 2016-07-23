require "idonethis_cli/client/team"

module IdonethisCli
  class Team < Command
    desc "list", "list your teams"
    long_desc "list the teams that you belong to"
    def list
      return nil unless authenticated?

      teams.each.with_index(1) do |team, idx|
        cli.say "#{idx}. #{team['name']}"
      end
    end

    desc "set", "set your team"
    long_desc "you will be prompted to set the team that you wish to create entries to"
    def set
      return nil unless authenticated?

      cli.choose do |menu|
        menu.prompt = "Please select the team you wish to set:"
        teams.each do |team|
          menu.choice(team['name']) do
            cli.say("#{team['name']} set")
            settings.set_team(team)
          end
        end
      end
    end

    desc "current", "show  your current set team"
    long_desc "show the current team that you will create entries to"
    def current
      cli.say "#{settings.team['name']}"
    end

    private
    def team_client
      @team_client ||= IdonethisCli::Client::Team.new(token)
    end

    def teams
      team_client.list
    end
  end
end
