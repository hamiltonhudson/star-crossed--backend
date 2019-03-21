class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:show, :update]
  # before_action :find_user, only: [:show, :sun_compats, :user_matches, :update, :update_matches]
  # after_action :user_matches, only: [:create, :update]

  def index
    @users = User.all
    render json: @users, status: 200
  end


  def show
    render json: @user, status: 200
  end


  def create
    @user = User.new(user_params)
    if @user.valid?
      # @user.save
      @user.find_matches
      @user.save
      render json: @user, status: 200
    else
      render json: @user.errors.full_messages
    end
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # @user.save
      @user.update_matches
      @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
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
    @user_pending_matches = @user.find_pending
    @user_awaiting_matches = @user.find_awaiting
      render json: [@name, {"accepted": @user_accepted_matches, "pending": @user_pending_matches, "awaiting": @user_awaiting_matches}]
  end

  def destroy
    @user = User.find(params[:id])
    # @user.matches.destroy
    # byebug
    @user.delete
    byebug
    @users = User.all
    # byebug
    render json: @users, status: 200
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birth_date, :birth_day, :birth_month, :birth_year, :sun, :gender, :gender_pref, :age, :location, :bio, :photo)
  end


  def find_user
   @user = User.find(params[:id])
  end

end

# User.second.sun.compat_signs.include?(User.first.sun.sign)
# User.first.sun.compat_signs.include?(User.second.sun.sign)
# User.first.gender_pref.include?(User.second.gender)
# User.second.gender_pref.include?(User.first.gender)
