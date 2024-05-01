class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[ index show update destroy ]

  # GET /users
  def index
    users = User.all
    render json: users, status: :ok
  end

  # GET /users/1
  def show
    user = User.find(params[:id])
    render json: user, status: :ok
  end

  # POST /users
  def create
    user = User.find_by(username: params[:username])
    if user
      render json: { error: "Username already taken" }, status: :unprocessable_entity
    else
      user = User.create!(user_params)
      token = encode_token(user_id: user.id)
      render json: { user: UserSerializer.new(user), jwt: token }, status: :created
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
