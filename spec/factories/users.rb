FactoryBot.define do
  class User
    attr_reader :email, :first_name, :last_name, :password
  
    def initialize(data)
      @email = data[:email]
      @first_name = data[:first_name]
      @last_name = data[:last_name]
      @password = data[:password]
    end
  end

  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.last_name }
    last_name { Faker::Name.last_name }
    password { '123123123' }
  end
end
