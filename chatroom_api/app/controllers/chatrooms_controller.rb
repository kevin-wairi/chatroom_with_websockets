class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: %i[ show update destroy ]
  skip_before_action :authorized

  # GET /chatrooms
  def index
    @chatrooms = Chatroom.all

    render json: @chatrooms
  end

  # GET /chatrooms/1
  def show
    render json: @chatroom
  end

  # POST /chatrooms
  def create
    @chatroom = Chatroom.new(chatroom_params)

    if @chatroom.save
      render json: @chatroom, status: :created
    else
      render json: @chatroom.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chatrooms/1
  def update
    if @chatroom.update(chatroom_params)
      render json: @chatroom
    else
      render json: @chatroom.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chatrooms/1
  def destroy
    @chatroom.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def chatroom_params
    params.require(:chatroom).permit(:title,:sender_id,:recipient)
  end
end
