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


  # def new
  #   @user = User.new
  # end


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
      # @user.update_matches
      @user.match_update
      @user.save
      # @user.update_matches
      @user.match_update
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

  # def user_matches
  #   @user.find_matches
  #   render json: @user, status: 200
  # end
  #
  # def sun_compats
  #   @name = @user.full_name
  #   @sun_compats = @user.sun.compatibilities
  #   render json: [@name, @sun_compats], status: 200
  # end

  # def current_matches
  #   @name = @user.full_name
  #   @user_matches = @user.find_matches
  #   render json: [@name, @user_matches]
  # render json: @user.errors, status: :unprocessable_entity
  # end

  # def updated_matches
  #   @user.matches.each do |match|
  #     match.destroy
  #   end
  #   @user.find_matches
  #   render json: @user.matches, status: 200
  # end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: @users, status: 200
  end


  private

  def user_params
   params.require(:user).permit(:first_name, :last_name, :birth_day, :birth_month, :birth_year, :gender, :gender_pref, :age, :location, :bio, :photo)
    # params.require(:user).permit(:user_id, :first_name, :last_name, :birth_day, :birth_month, :birth_year, :gender, :gender_pref, :age, :location, :bio, :photo)
  end


  def find_user
   @user = User.find(params[:id])
  end

end
