class CommentsController < ApplicationController
	before_action :load 
	before_filter :authenticate, :expect => :show

	def create
		@comment = @post.comments.new(comment_params)
		@comment.user = @user
		
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
		@post = current_user.posts.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to @post, notice: 'Comment Deleted' }
			format.js
		end
	end

	private
	def load
		@post = Post.find(params[:post_id])
		@user = current_user
	end

	def comment_params
		params.require(:comment).permit(:name, :email, :body)
	end
end
