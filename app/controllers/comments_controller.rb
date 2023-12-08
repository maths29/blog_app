class CommentsController < ApplicationController
  def new
    @user = Post.find(params[:post_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @comment = Comment.new
    @comment.author_id = @user.id
    @comment.post_id = params[:post_id]
    @comment.body = params[:comment][:text]

    if @comment.save
      flash[:success] = 'Comment created successfully'
    else
      flash[:error] = 'Something went wrong.'
      puts @comment.errors.full_messages # Check the server console for error messages
      render :new
    end

    redirect_to user_post_path(params[:user_id], @comment.post_id)
  end

  private

  def comment_params
    p params
    params.require(:comment).permit(:text)
  end
end
