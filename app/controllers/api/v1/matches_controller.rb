class Api::V1::MatchesController < ApplicationController
  before_action :authenticate_user

  def index
    @matches = Match.all
    render json: @matches, status: 200
  end


  def show
    @match = Match.find(params[:id])
    render json: @match, status: 200
  end


  def create
    @match = Match.create(match_params)
    if @match.valid?
      render json: @match, status: 200
    else
      render json: @match.errors_full_messages, status: :unprocessable_entity
    end
  end


  def update
    find_match
    if @match.update(match_params)
      render json: @match, status: 200
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end


  def accept
    @match = Match.find(params[:id])
    @match.accept_match
    @user = @match.user
    @user.save
    @users = User.all
    render json: {
      user: UserSerializer.new(@user),
      match_status: @match.status,
    }, status: 200
  end


  def decline
    @match = Match.find(params[:id])
    @match.decline_match
    @user = @match.user
    @user.save
    @users = User.all
    render json: {
      user: UserSerializer.new(@user),
      match_status: @match.status,
    }, status: 200
  end


  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    render @matches, status: 200
  end


  private

  def match_params
    params.require(:match).permit(:user_id, :matched_user_id)
  end


  def find_match
    @match = Match.find(params[:id])
  end


end
