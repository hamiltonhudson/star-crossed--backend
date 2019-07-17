class ChatsChannel < ApplicationCable::Channel

  def subscribed
    stream_from "current_user_#{current_user.id}"
    puts "listening to chat"
  end

  def unsubscribed
    stop_all_streams
    puts "chat ended"
  end

end
