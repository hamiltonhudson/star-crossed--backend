class Api::V1::UsersController < ApplicationController
  # before_action :requires_login, only: [:index, :show]
  before_action :authenticate_user, only: [:show]
  # before_action :find_user, only: [:show, :update]

  def index
    @users = User.all
    render json: @users, status: 200
  end


  def show
    @user = User.find_by(id: params[:id])
    render json: @user
  end

  def create
    # @user = User.create!(user_params)
    # if @user.valid?
    @user = User.new(user_params)
    if (@user.save)
      @user.find_matches
      @user.save
      render json: {
        user: UserSerializer.new(@user),
        id: @user.id,
        token: get_token(payload(@user, @user.id)),
        cookies: cookies.signed[:token]
        }, status: :accepted
    else
      render json: {
        errors: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    find_user
    @user.update(user_params)
      if @user.save
      @user.update_matches
      @user.save
      render json: {
        user: UserSerializer.new(@user),
        id: @user.id,
        token: get_token(payload(@user, @user.id))
        }, status: :accepted
    else
      render json: {
        errors: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end


  def match_update
    @user = User.find(params[:id])
    @user.update_matches
    @user_matches = @user.update_matches
    render json: @user_matches, status: 200
  end


  def current_matches
    @user = User.find(params[:id])
    @name = @user.full_name
    @user_accepted_matches = @user.find_accepted
    @accepted_matched_users = @user.find_accepted_matched_users
    @user_pending_matches = @user.find_pending
    @user_awaiting_matches = @user.find_awaiting
      render json: [@name, {"accepted": @user_accepted_matches, "accepted users": @accepted_matched_users, "pending": @user_pending_matches, "awaiting": @user_awaiting_matches}]
  end


  def destroy
    @user = User.find(params[:id])
    # @user.matches.destroy
    @user.matches.delete_all
    @user.delete
    @users = User.all
    render json: @users, status: 200
  end


  def users_chats
    @user = User.find_by(id: params[:user_id])
    render json: @user.user_chats
  end


  def auth
    if !valid_token?
      render json: {
        message: "NOPE!"
      }, status: :unauthorized
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :first_name, :last_name, :birth_date, :birth_day, :birth_month, :birth_year, :sun, :gender, :gender_pref, :age, :location, :bio, :photo)
    end

    def find_user
      @user = User.find_by(id: params["id"])
    end

end
