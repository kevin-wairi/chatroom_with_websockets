class ApplicationController < ActionController::API
  before_action :authorized


  def encode_token(token)
    JWT.encode(token, "my_s3cr3t", "HS256")
  end

  def auth_header
    request.headers["Authorization"]
  end

  def decoded_token
    if auth_header
      token = auth_header.split(" ")[1]
      begin
        JWT.decode(token, "my_s3cr3t", true, algorithm: "HS256")
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]["user_id"]
      user = User.find(user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { error: "Not Authorized, Please login" }, status: :unauthorized unless logged_in?
  end
end
