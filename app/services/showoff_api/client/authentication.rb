# frozen_string_literal: true

# # frozen_string_literal: true

module ShowoffApi
  module Client
    class Authentication < Base
      def endpoint
        'oauth/token'
      end

      def request_body(user)
        {
          grant_type: 'password',
          client_id: @client_id,
          client_secret: @client_secret,
          username: user[:email],
          password: user[:password]
        }
      end

      def login(user)
        response = do_post(request_body(user))

        parsed_body = parse(response.body)

        if response.code == 200
          hash_response(:success, parsed_body['data'])
        else
          hash_response(:error, parsed_body['message'])
        end
      end
    end
  end
end
