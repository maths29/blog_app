class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  def show
    @post = Post.find(params[:id])
    @index = params[:index]
    @user = current_user
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @user = current_user
    @post = Post.new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to user_posts_path(id: current_user.id)
    else
      flash.now[:alert] = 'Cannot create a new post'
      render :new
    end
  end

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id).includes(:comments, :user).paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @author = @post.user
    @author.decrement!(:posts_counter)
    @post.destroy
    if @post.destroy
      redirect_to user_posts_path(current_user), notice: 'post was successfully deleted.'
    else
      redirect_to redirect_url, alert: 'Failed to delete the post.'
    end
  end

  def api_index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id).includes(:comments, :user).paginate(page: params[:page], per_page: 10)
    render json: @posts
  end

  def api_comments
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: @comments
  end

  def api_add_comment
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      render json: @comment, status: :created
    else
      render json: { error: 'Failed to create comment' }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
