class SiteController < ApplicationController

  def home
    if current_user
      @posts = Post.from_users_followed_by(current_user).
        paginate(:page => params[:page], :per_page => 10).
        order('created_at DESC')
    end
  end

  def about
  end

  def contact
  end
end
