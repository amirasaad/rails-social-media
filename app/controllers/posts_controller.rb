class PostsController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :update_poststreams, :only => [:index , :refreshPosts]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.find(:all , :order => 'posts.created_at DESC')
    respond_to do |format|
      format.html 
      format.json{ render :json => @posts}
      format.js
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
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
    @post.ups = 0
    @post.downs = 0

    respond_to do |format|
      if @post.save
        format.js
        format.html { redirect_to action: 'index' }
        format.json { render action: 'show', status: :created, location: @post }
        
      else
        format.html { redirect_to root_path }
        format.json { render json: @post.errors, status: :unprocessable_entity }
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
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
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

  def votedup
    @post = Post.find(params[:id])
    @post.ups=@post.ups+1
    @post.save
    render :text => "<div class='up'></div>"+@post.ups.to_s+" Ups"
  end

  def voteddown
    @post = Post.find(params[:id])
    @post.downs=@Post.downs+1
    @post.save
    render :text => "<div class='down'></div>"+@post.downs.to_s+" Downs"
  end

  def refreshposts
    render :partial => 'posts.html.erb', :locals => { :posts_streams => @posts_streams }
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
