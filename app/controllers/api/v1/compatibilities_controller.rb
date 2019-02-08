class Api::V1::CompatibilitiesController < ApplicationController

  def index
    @compatibilities = Compatibility.all
    render json: @compatibilities, status: 200
  end

  def show
    @compatibility = Compatibility.find(params[:id])
    render json: @compatibility, status: 200
  end

  def create
    # @compatiblity = Compatibility.create(params[:id])
    @compatibility = Compatibility.create(compatibility_params)
    if @compatibility.valid?
      render json: @compatiblity, status: 200
    else
      render json: @compatiblity.errors_full_messages, status: :unprocessable_entity
    end
  end

  private

  def compatibility_params
    params.require(:id).permit(:sun_id, :compatible_sun_id)
  end

end
