class ConversationsChannel < ApplicationCable::Channel

  def subscribed
    chat = Chat.find(params[:chat])
    stream_for chat
    puts "listening to conversation"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    puts "conversation ended"
  end
end
