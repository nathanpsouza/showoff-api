# frozen_string_literal: true

module ShowoffApi
  module Client
    class User < Base
      def endpoint
        'api/v1/users'
      end

      def request_body(user)
        {
          user: user.to_hash,
          client_id: @client_id,
          client_secret: @client_secret
        }
      end

      def save(user)
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
