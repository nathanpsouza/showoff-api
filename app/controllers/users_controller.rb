# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.valid?
      user = user_client.save(user)
      render json: user, status: :created
    else
      data = { status: :error, data: { errors: user.errors.messages } }
      render json: data, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :email, :first_name, :last_name, :password, :password_confirmation
      )
    end

    def user_client
      @client ||= ShowoffApi::Client.user
    end
end
