# class Api::V1::AuthController < ApplicationController
class Api::V1::AuthController < Api::V1::KnockTokenController
  include Knock::Authenticable
  skip_before_action :verify_authenticity_token

  def new
    @users = User.all
  end

  # def create
  #   @user = authenticate_user(params[:user_id])
  #   byebug
  #   render @user
  # end

  def create
    @user = User.find_by(email: params["email"])
    if (@user && @user.authenticate(params["password"]))
    created_jwt = get_token(payload(@user, @user.id))
    cookies.signed[:jwt] = {value: created_jwt, httponly: true}
    # byebug
    render json: {
      user: UserSerializer.new(@user),
      id: @user.id,
      token: get_token(payload(@user, @user.id))
      }, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  # def create
  #   @user = User.find_by(email: params["email"])
  #   if (@user && @user.authenticate(params["password"]))
  #     created_jwt = get_token(payload(@user, @user.id))
  #     cookies.signed[:jwt] = {value: created_jwt, httponly: true}
  #     render json: {
  #       user: UserSerializer.new(@user),
  #       id: @user.id
  #     }, status: :accepted
  #   else
  #     render json: { message: 'Invalid username or password' }, status: :unauthorized
  #   end
  # end

  def destroy
    cookies.delete(:jwt)
  end

end
