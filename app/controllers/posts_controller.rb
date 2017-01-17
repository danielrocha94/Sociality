class PostsController < ApplicationController
  before_action :logged_in_user, only: [:vote, :new, :create, :destroy, :update]
  before_action :correct_user, only: :destroy
  before_action :admin_user, only: [:destroy, :update]
  include Sessionable
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new(post_id: @post, user_id: current_user.id, content: "")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "Post created!"
      redirect_to posts_path
    else
      flash[:danger] = "Post could not be created!"
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  def downvote
    @selected = Post.find(params[:id])
    @vote = @selected
    if @selected.downvote!(current_user)
      respond_to do |format|
        format.html do
          flash[:success] = "Downvoted!"
          redirect_to(:back)
        end
        format.js { render :file => "/comments/downvote" }
      end
    end
  end

  def upvote
    @selected = Post.find(params[:id])
    @vote = @selected
    if @selected.upvote!(current_user)
      respond_to do |format|
        format.html do
          flash[:success] = "Upvoted!"
          redirect_to(:back)
        end
        format.js { render :file => "/comments/upvote" }
      end
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :content)
    end

end
