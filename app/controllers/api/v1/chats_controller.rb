class Api::V1::ChatsController < ApplicationController
  # before_action :requires_login, only: [:index, :create]
  before_action :authenticate_user


  def index
    @user = User.find_by(id: authenticate_user[0]["id"])
    user_id = @user.id
    @chats = @user.chats
    # @serialized_data = ActiveModelSerializers::Adapter::Json.new(
    #   ChatSerializer.new(@chat)
    # ).serializable_hash
    ActionCable.server.broadcast(
      "current_user_#{params["user_id"]}",
      @chats
    )
    render json: @chats
  end


  def create
    @chat = Chat.new(chat_params)
      if @chat.save
        unless Conversation.exists?
          @ownership1 = Conversation.new()
          @ownership1.chat_id = @chat.id
          @ownership1.user_id = params["sender_id"]
          @ownership1.save
          @ownership2 = Conversation.new()
          @ownership2.chat_id = @chat.id
          @ownership2.user_id = params["receiver_id"]
          @ownership2.save
          @serialized_data = ActiveModelSerializers::Adapter::Json.new(
            ChatSerializer.new(@chat)
          ).serializable_hash
          ActionCable.server.broadcast(
            "current_user_#{params["sender_id"]}",
            @serialized_data
          )
          ActionCable.server.broadcast(
            "current_user_#{params["receiver_id"]}",
            @serialized_data
          )
          head :ok
      end
    end
  end

  private
    def chat_params
      # params.require(:chat).permit(:id, :title, :sender_id, :receiver_id)
      params.require(:chat).permit(:id, :title, :sender_id, :receiver_id)
    end

end
