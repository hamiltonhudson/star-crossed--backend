class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_user


  # def create
    # subscription = Subscription.new(subscription_params)
    # # subscription.user_id = current_user.id
    # subscription.sender = User.find_by(id: chat_params["sender_id"])
    # subscription.receiver = User.find_by(id: chat_params["receiver_id"])
    # chat = Chat.find(subscription_params[:chat_id])
    #  if subscription.save
    #    serialized_data = ActiveModelSerializers::Adapter::Json.new(
    #      SubscriptionSerializer.new(subscription)
    #    ).serializable_hash
    #    SubscriptionsChannel.broadcast_to(
    #      chat,
    #      serialized_data
    #    )
    #    head :ok
     # end
   # end


  # private
  #   # def subscription_params
    #   params.require(:subscription).permit(:id, :chat_id, :sender_id, :receiver_id)
    # end

end
