module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user


    def connect
      self.current_user = find_verified_user
    end

    # def connect
    #   # self.current_user = User.find_by(request.params[:user_id])
    #   # self.current_user = User.find_by(id: request.params[:id])
    #   # self.current_user = User.find_by(id: request.params[:user])
    #   # self.current_user = User.find_by(id: request.params[:user_id])
    #   # self.current_user = User.find_by(params[:user_id])
    #   # self.current_user = User.find_by(id: cookies.signed[:user_id])
    # end

    private

    def find_verified_user
      # if current_user = User.find_by(request.params[:user_id])
      if current_user = User.find_by(id: request.params[:id])

        current_user
      else
        reject_unauthorized_connection
      end
    end


  end
end
