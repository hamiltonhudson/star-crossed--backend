class ConversationsChannel < ApplicationCable::Channel
  # def subscribed
  #   # stream_from "some_channel"
  # end
  def subscribed
    chat = Chat.find(params[:chat])
    stream_for chat
    puts "listening to conversation"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    puts "listening to conversation ended"
  end
end
