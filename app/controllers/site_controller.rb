class SiteController < ApplicationController
	respond_to :html, :xml, :js
	def home
		if logged_in?
			@posts = Post.from_users_followed_by(current_user).paginate(:page => params[:page], :per_page =>5).order('created_at DESC')
		end
	end

	def about
	end

	def contact
	end

end
