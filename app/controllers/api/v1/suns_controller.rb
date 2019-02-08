class Api::V1::SunsController < ApplicationController

  def index
    @suns = Sun.all
    # @compatible_suns = Sun.compatible_suns
    render json: @suns, status: 200
  end

  def

  def show
    @sun = Sun.find(params[:id])
    render json: @sun, status: 200
  end


  ## custom routes for custom methods
  ## user logs in and there's an action to establisth their compatibilities

  # private
  #
  #  def sun_params
  #    params.require(:sun).permit(:sign, :start_date, :end_date, :compat_signs)
  #  end

end
