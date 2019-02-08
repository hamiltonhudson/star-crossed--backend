class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:show, :sun_compats, :user_matches, :update]
  # after_action :user_matches, only: [:create, :update]

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    render json: @user, status: 200
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      @user.find_matches
      render json: @user, status: 200
    else
      render json: @user.errors.full_messages
    end
  end

  def user_matches
    @user.find_matches
    render json: @user, status: 200
  end

  def sun_compats
    @name = @user.full_name
    @sun_compats = @user.sun.compatibilities
    render json: [@name, @sun_compats], status: 200
  end

  # def user_matches
  #   @name = @user.full_name
  #   @user_matches = @user.find_matches
  #   render json: [@name, @user_matches]
  # render json: @user.errors, status: :unprocessable_entity
  # end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # def remove_match(declined_match)
  #   @user = User.find(params[:id])
  #   match = @user.matches.find(match.id == declined_match.id)
  #   @user.declined_matches.push(match)
  #   @user.matches.delete(match)
  #   @user.save
  #   render json: {user: user, matches: user.matches, status: "decline successful, matches updated"}
  # end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: @users, status: 200
  end

  private

  def user_params
     params.require(:user).permit(:first_name, :last_name, :birth_year, :birth_month, :birth_day, :zodiac_id)
   end

   def find_user
     @user = User.find(params[:id])
   end

end
