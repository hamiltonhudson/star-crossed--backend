class MatchesController < ApplicationController

  def index
    @matched = Match.all
    render json: @matches, status: 200
  end

  def show
    @match = Match.find(params[:id])
    render json: @match, status: 200
  end


  def create
    # @match = Match.create(params[:id])
    @match = Match.create(match_params)
    if @match.valid?
      render json: @match, status: 200
    else
      render json: @match.errors_full_messages, status: :unprocessable_entity
    end
  end

  # def remove(declined_by)
  #   @match = Match.find(params[:id])
  #   # user = @match.user_id == declined_by.id || @match.matched_user_id == declined_by.id
  #   user.declined_matches.push(@match)
  #   @match.delete
  #   @user.save
  # end

  # def destroy
  #   @match = Match.find(params[:id])
  #   @match.destroy
  #   render @matches, status: 200
  # end

  private

  # def match_params
  #   params.require(:match).permit(:user_id, :matched_user_id)
  # end

end
