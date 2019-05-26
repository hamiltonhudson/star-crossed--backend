class Api::V1::ChatsController < ApplicationController
  # before_action :identified_by,  only: [:index, :create]


  def index
    @chats = Chat.select { |chat| chat.user_ids.include?(current_user.id)}
    render json: @chats, include: "users,conversations,conversations.user"
  end

#
#   def create
#     @chat = Chat.new(chat_params)
#       if @chat.save
#         @ownership1 = Subscription.new()
#         @ownership1.chat_id = @chat.id
#         @ownership1.user_id = params["sender_id"]
#         @ownership1.save
#         @ownership2 = Subscription.new()
#         @ownership2.chat_id = @chat.id
#         @ownership2.user_id = params["receiver_id"]
#         @ownership2.save
# # byebug
#         @serialized_data = ActiveModelSerializers::Adapter::Json.new(
#           ChatSerializer.new(@chat)
#         ).serializable_hash
#
#         ActionCable.server.broadcast(
#         "current_user_#{current_user.id}",
#         @serialized_data
#       )
#       # byebug
#         ActionCable.server.broadcast(
#           "current_user_#{params["receiver_id"]}",
#           @serialized_data
#         )
#           head :ok
#     end
#   end

  def create

    # 1. Create a new chat in the db.
    chat = Chat.new(chat_params)

    if chat.save

        # 2. Create each relationship between chat and both users via join table user_chat. Both chat users are passed in params.
        ownership1 = Subscription.new()
        ownership1.chat_id = chat.id
        ownership1.user_id = params["sender_id"]
        ownership1.save
        ownership2 = Subscription.new()
        ownership2.chat_id = chat.id
        ownership2.user_id = params["receiver_id"]
        ownership2.save

        # 3. Get the serialized data for the chat as defined in ChatSerializer
        serialized_data = ActiveModelSerializers::Adapter::Json.new(
            ChatSerializer.new(chat)
        ).serializable_hash

         # 3. Broadcast new serialized chat to both channel subscribers.
        ActionCable.server.broadcast(
            # Broadcast to general open channel
            # 'conversations_channel',

            # Broadcast to user/sender private channel
            "current_user_#{current_user.id}",
            serialized_data
        )

        ActionCable.server.broadcast(
            # Broadcast to user/receiver private channel
            "current_user_#{params["receiver_id"]}",
            serialized_data
        )

        head :ok
    end
end

  private

  def chat_params
    params.require(:chat).permit(:id, :title, :sender_id, :receiver_id)
    # params.require(:chat).permit(:title, :sender_id, :receiver_id)
    # params.require(:chat).permit(:id, :sender_id, :receiver_id)
  end


end
