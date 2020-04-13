# frozen_string_literal: true

module ShowoffApi
  module Client
    class User < Base
      def endpoint
        'api/v1/users'
      end

      def save(user)
        response = do_post(request_body(user))

        handle_response(response)
      end

      private
        def request_body(user)
          {
            user: user.to_hash,
            client_id: @client_id,
            client_secret: @client_secret
          }
        end
    end
  end
end
