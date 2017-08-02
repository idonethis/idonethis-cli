module IdonethisCli
  module Client
    class Entry
      attr_reader :error, :token

      def initialize(token)
        @token = token
      end

      def create(team_id, body)
        response = token.post(API_PATH + '/entries', 
                              params: { body: body, team_id: team_id})
        JSON.parse(response.body)
      rescue => e
        @error = e.response
        false
      end

      def create_goal(team_id, body)
        response = token.post(API_PATH + '/entries', 
                              params: { body: body,
                                        team_id: team_id,
                                        status: 'goal'})
        JSON.parse(response.body)
      rescue => e
        @error = e.response
        false
      end

      def list(team_id)
        response = token.get(API_PATH + '/entries', { team_id: team_id })
        entries  = JSON.parse(response.body)
      rescue => e
        @error = e.response
        false
      end
    end
  end
end
