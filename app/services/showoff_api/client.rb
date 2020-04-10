# frozen_string_literal: true

module ShowoffApi
  module Client
    def self.user
      verify_api_credentials
      User.new(ENV['API_ADDRESS'], ENV['CLIENT_ID'], ENV['CLIENT_SECRET'])
    end

    def self.verify_api_credentials
      ['API_ADDRESS', 'CLIENT_ID', 'CLIENT_SECRET'].each do |env|
        unless ENV.has_key?(env)
          raise RuntimeError.new("You must provide #{env} environment variable")
        end
      end
    end
  end
end
