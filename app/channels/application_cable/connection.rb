module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include ActionController::Cookies
    include Knock::Authenticable
    identified_by :current_user


    def connect
      self.current_user = find_verified_user
    end

  private
    def find_verified_user
      @jwt_token = request.cookies["X-Authorization"]
      user_id = JWT.decode(@jwt_token, Knock.token_secret_signature_key.call, false)[0]["id"]
      if current_user = User.find_by(id: user_id)
        current_user
      else
        reject_unauthorized_connection
      end
    end


  end
end
