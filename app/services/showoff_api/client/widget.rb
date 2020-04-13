# frozen_string_literal: true

module ShowoffApi
  module Client
    class Widget < Base
      def endpoint
        'api/v1/widgets/visible'
      end

      def visible(term = nil)
        response = do_get(query_string(term))

        parsed_body = parse(response.body)

        if response.code == 200
          hash_response(:success, parsed_body['data'])
        else
          hash_response(:error, parsed_body['message'])
        end
      end

      private
        def query_string(term)
          query = {
            client_id: @client_id,
            client_secret: @client_secret
          }

          query[:term] = term if term

          query
        end
    end
  end
end
