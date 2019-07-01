class Api::V1::AuthController < ApplicationController

  def create
    @user = User.find_by(email: params["email"])
    if (@user && @user.authenticate(params["password"]))
      render json: {
        user: @user,
        id: @user.id,
        token: get_token(payload(@user.email, @user.id))
      }
    else
      render json: {
        errors: "Those credentials don't match anything we have in our database"
      }, status: :unauthorized
    end
  end

end
