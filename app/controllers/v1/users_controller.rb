class V1::UsersController < ApplicationController
  before_action :authenticate_v1_user!
  respond_to :json

  has_scope :has_role, :institution

  def index
    users = apply_scopes(User).all
    render json: users, status: 200
  end

  def show
    user = User.find params[:id]
    render json: user, status: 200, location: [:v1, user]
  end

  def create
    user = User.new(user_params)
    password = Devise.friendly_token.first(8)
    user.password = password
    if user.save
      render json: user, status: 201, location: [:v1, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = User.find params[:id]
    if user.update(user_params)
      render json: user, status: 200, location: [:v1, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :institution_id)
    end
end
