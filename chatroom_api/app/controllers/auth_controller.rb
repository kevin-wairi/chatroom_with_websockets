class AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    user = User.find_by(username: params[:username])
    puts ""
    puts ""
    puts ""
    puts "USER #{user.username}"
    puts ""
    puts ""
    puts ""
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { user: UserSerializer.new(user), jwt: token }, status: :accepted
    else
      render json: { error: "Invalid credentials" }, status: unauthorized
    end
  end
end
