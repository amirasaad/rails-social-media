class PostsController < ApplicationController
  before_action :authenticate
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :update_poststreams, :only => [:index , :refreshPosts]

  # GET /posts
  # GET /posts.json
  def index
    if logged_in?
      @posts = Post.from_users_followed_by(current_user).paginate(:page => params[:page], :per_page =>5).order('created_at DESC')
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
     respond_to do |format|
      format.html 
      format.js
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.js
        format.html { redirect_to action: 'index' }
        format.json { render action: 'show', status: :created, location: @post }
        
      else
        format.html { redirect_to root_path }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js { render 'fail_create.js.erb' }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.js
        format.html { redirect_to action: 'index', notice: 'Post was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit( :body)
    end

    def update_poststreams
      @posts_streams = Post.order('created_at DESC').all
    end 

    
  end
