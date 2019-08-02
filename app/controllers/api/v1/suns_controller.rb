class Api::V1::SunsController < ApplicationController
  before_action :authenticate_user, only: [:index, :show]

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
    if @sun.valid?
      @sun.save
  end

  private
    def sun_params
      params.require(:sun).permit(:sign, :start_date, :end_date, :compat_signs)
    end

end
