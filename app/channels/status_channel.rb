class StatusChannel < ApplicationCable::Channel
  # def subscribed
  #   stream_from "status _channel"
  #   current_user.active_user = true
  #   current_user.save
  #   ActionCable.server.broadcast("status_channel", {type: "CO_USER", user: current_user.id})
  # end
  #
  # def unsubscribed
  #   current_user.active_user = false
  #   current_user.save
  #   ActionCable.server.broadcast("status_channel", type: "DC_USER", user: current_user.id)
  # end
end
