class V1::InstitutionsController < ApplicationController
  before_action :authenticate_v1_user!
  respond_to :json

  def show
    institution = Institution.find params[:id]
    render json: institution, status: 200, location: [:v1, institution]
  end

  def create
    institution = Institution.new(institution_params)
    if institution.save
      render json: institution, status: 201, location: [:v1, institution]
    else
      render json: { errors: institution.errors }, status: 422
    end
  end

  def update
    institution = Institution.find(params[:id])

    if institution.update(institution_params)
      render json: institution, status: 200, location: [:v1, institution]
    else
      render json: { errors: institution.errors }, status: 422
    end
  end

  def destroy
    institution = Institution.find(params[:id])
    institution.destroy
    head 204
  end

  private

    def institution_params
      params.require(:institution).permit(:name)
    end
end
