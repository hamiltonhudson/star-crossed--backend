class Api::V1::ChatsController < ApplicationController
  before_action :authenticate_user


  def index
    @user = User.find_by(id: authenticate_user[0]["id"])
    user_id = @user.id
    # @chats = @user.chats
    @chats = Chat.select { |chat| chat.user_ids.include?(@user.id)}
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
    @sender = User.find(params["sender_id"])
    @receiver = User.find(params["receiver_id"])
    @chat = Chat.new(chat_params)
      if @chat.save
        @ownership1 = Subscription.new()
        @ownership1.chat_id = @chat.id
        @ownership1.user_id = @sender.id
        @ownership1.save
        @ownership2 = Subscription.new()
        @ownership2.chat_id = @chat.id
        @ownership2.user_id = @receiver.id
        @ownership2.save
        # if @subscription.save
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
        # head :ok
        render json: @chat
    end
  end

  private
    def chat_params
      params.require(:chat).permit(:title, :sender_id, :receiver_id)
    end

end
