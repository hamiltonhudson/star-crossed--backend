class Api::V1::AuthController < ApplicationController
  include Knock::Authenticable

  def create
    @user = User.find_by(email: params["email"])
    if (@user && @user.authenticate(params["password"]))
    created_jwt = get_token(payload(@user, @user.id))
    cookies.signed[:jwt] = {value: created_jwt, httponly: true}
    render json: {
      user: UserSerializer.new(@user),
      id: @user.id,
      token: get_token(payload(@user, @user.id))
      }, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def destroy
    cookies.delete(:jwt)
  end

end
