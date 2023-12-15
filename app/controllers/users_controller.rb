class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @user = current_user
  end
end
