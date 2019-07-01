class Api::V1::SunsController < ApplicationController
  before_action :requires_login, only: [:index, :show]

  def index
    @suns = Sun.all
    render json: @suns, status: 200
  end

  def

  def show
    @sun = Sun.find(params[:id])
    render json: @sun, status: 200
  end

  def create
    @sun = Sun.new(sun_params)
    # if @sun.valid?
    # @compatible_suns = [@sun.compatible_suns, @sun.inverse_compatible_suns]
    # @compatible_suns = @sun.compatible_suns && @sun.inverse_compatible_suns
    # @compatible_suns = @sun.compatible_suns + @sun.inverse_compatible_suns
    #   @sun.save
    if @sun.save
    # render json: @sun, status: 200
  end

  private

   def sun_params
     params.require(:sun).permit(:sign, :start_date, :end_date, :compat_signs)
   end

end
