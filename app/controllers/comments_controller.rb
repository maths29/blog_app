class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @user = current_user
    @comment = @user.comments.build(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      flash[:success] = 'Comment created successfully!'
    else
      flash[:error] = 'Comment could not be saved.'
    end
    redirect_to user_post_path(current_user, @comment.post_id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    if @comment.destroy
      flash.now[:success] = 'Comment was successfully deleted!'
    else
      flash[:error] = 'Comment couldnt be deleted!'
    end
    redirect_to user_post_path(@comment.post.user, @comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
