# frozen_string_literal: true

class User
  include ActiveModel::Model

  attr_accessor :email,
    :first_name,
    :last_name,
    :password,
    :password_confirmation

  validates :email, {
    presence: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }
  }
  validates :password,
    confirmation: true,
    length: { minimum: 8 },
    if: -> { password.present? }
end
