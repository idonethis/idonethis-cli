module IdonethisCli
  module Client
    class Team
      attr_reader :token

      def initialize(token)
        @token = token
      end

      def list
        response = token.get(API_PATH + '/teams')
        teams    = JSON.parse(response.body)
      end
    end
  end
end
