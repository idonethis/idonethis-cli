require "idonethis_cli/client/entry"

module IdonethisCli
  class Entry < Command
    desc "new BODY", "enter a single entry"
    long_desc "create an entry for your set team"
    def new(body)
      return nil unless authenticated?
      return nil unless team_set?
      post_entry body
    end

    desc "prompt", "enter multiple entries"
    long_desc "prompts for your entries"
    def prompt
      return nil unless authenticated?
      return nil unless team_set?

      cli.say "Enter your entries.  Hit <enter> when done."

      body = cli.ask "What did you get done?"

      while body.length > 1
        post_entry body
        body = cli.ask "What did you get done?"
      end
    end

    desc "list", "list your entries"
    long_desc "list the entries for the team you belong to"
    def list
      return nil unless authenticated?
      return nil unless team_set?

      if entries = entry_client.list(settings.team['hash_id'])
        entries.each.with_index(1) do |entry, idx|
          cli.say "#{entry['created_at']} : #{entry['status']} : #{entry['body']}"
        end
      else
        cli.say "Could not retrieve entries.  #{entry_client.error}"
      end
    end

    private
    def entry_client
      @client ||= IdonethisCli::Client::Entry.new(token)
    end

    def post_entry(body)
      response = entry_client.create(settings.team['hash_id'], body)
      if response
        cli.say "Entry created for #{response['user']['full_name']} on #{settings.team['name']}"
      else
        cli.say "Entry could not be created #{entry_client.error}"
      end
    end
  end
end
