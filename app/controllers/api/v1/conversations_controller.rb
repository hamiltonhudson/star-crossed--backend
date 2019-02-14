class Api::V1::ConversationsController < ApplicationController
  # before_action :identified_by,  only: [:index, :create]


  def create
    conversation = Conversation.new(conversation_params)
    conversation.user_id = current_user.id
    chat = Chat.find(conversation_params[:chat_id])
     if conversation.save
       serialized_data = ActiveModelSerializers::Adapter::Json.new(
         ConversationSerializer.new(conversation)
       ).serializable_hash
       ConversationsChannel.broadcast_to(
         chat,
         serialized_data
       )
       head :ok
     end
   end


  private

  def conversation_params
    params.require(:conversation).permit(:message, :chat_id)
    # params.require(:conversation).permit(:message, :chat_id, :user_id)
  end

end
