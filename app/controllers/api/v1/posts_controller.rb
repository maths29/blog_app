class Api::V1::PostsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @posts = @user.posts.all
    render json: @posts
  end
end
