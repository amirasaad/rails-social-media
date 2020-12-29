class CommentsController < ApplicationController
  before_action :authenticate_user!, :expect => :show
  before_action :correct_user , only: [:edit ,:update , :destroy]
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_path, notice: 'your comment posted' }
        format.js
      else
        format.html { redirect_to posts_path, alert: 'Unable to add comment' }
        format.js { render 'fail_create.js.erb' }
      end
    end
  end

  def show
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Comment Deleted' }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def correct_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    redirect_to(root_url) unless signed_in?(@comment.user ) || signed_in?(@post.user)
  end
end
