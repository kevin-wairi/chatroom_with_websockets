class MessagesController < ApplicationController
  # before_action :set_current_user, only: [:create]
  skip_before_action :authorized

  # GET /messages
  def index
    puts "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW #{current_user}"
    messages = Message.all

    render json: messages
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    puts " "
    puts " "
    puts "Creating message #{params}"
    puts "1 "
    puts "2 "
    puts "3 "
    user = User.find_by(id: params[:user_id])
    chatroom = Chatroom.find_by(sender_id: params[:user_id], recipient_id: params[:recipient_id]) || Chatroom.find_by(sender_id: params[:recipient_id], recipient_id: params[:user_id]) || Chatroom.create!(sender_id: params[:user_id], recipient_id: params[:recipient_id])
    puts "CHATROOMMMMMMMMMMMMMMMM #{chatroom}"
    puts ""
    puts ""
    puts "1111111111111111111111111111111111111111111111111 #{user}"
    message = user.messages.create!(message_params.merge(chatroom_id: chatroom.id))
    ActionCable.server.broadcast("chat_#{params[:recipient_id]}#{params[:user_id]}", message)
    render json: message, status: :created
    puts "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: message.full_messages }, status: :unprocessable_entity
    puts "RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR"
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  def set_current_user
    @current_user = current_user
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:content, :user_id, :recipient_id, :chatroom_id)
  end
end
