# frozen_string_literal: true

module ShowoffApi
  module Client
    class User
      attr_reader :api_address, :client_id, :client_secret

      def initialize(api_address, client_id, client_secret)
        @api_address = api_address
        @client_id = client_id
        @client_secret = client_secret
      end

      def save(user)
        response = do_request(user_request_body(user))

        parsed_body = parse(response.body)

        if response.code == 200
          hash_response(:success, parsed_body['data'])
        else
          hash_response(:error, parsed_body['message'])
        end
      end

      private
        def parse(string)
          JSON.parse(string)
        end

        def hash_response(status, data)
          ActiveSupport::HashWithIndifferentAccess.new(
            { status: status, data: data }
          )
        end

        def resource
          @resource ||= ::RestClient::Resource.new("#{@api_address}/users")
        end

        def user_request_body(user)
          {
            user: user,
            client_id: @client_id,
            client_secret: @client_secret
          }
        end

        def do_request(request_body)
          resource.post(request_body.to_json, content_type: 'application/json')
        rescue RestClient::ExceptionWithResponse => e
          e.response
        end
    end
  end
end
