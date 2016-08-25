module IdonethisCli
  module Client
    class Auth
      attr_reader :error, :api_token

      def authenticate()
        # TODO
      end

      def oauth2_client
        @oauth2_client ||= OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, site: BASE_URL)
      end

      def url
        oauth2_client.auth_code.authorize_url(redirect_uri: 'urn:ietf:wg:oauth:2.0:oob')
      end

      def oauth2_token(code)
        oauth2_client.auth_code.get_token(code, redirect_uri: 'urn:ietf:wg:oauth:2.0:oob')
      end

      def token(oauth2_token)
        current_token = OAuth2::AccessToken.from_hash(oauth2_client, oauth2_token)
        current_token.expired? ? current_token.refresh! : current_token
      end
    end
  end
end
