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
    post = Post.find(params[:id])
    post.downvote!
    head :no_content
  end

  def upvote
    post = Post.find(params[:id])
    post.upvote!
    head :no_content
  end

  private
    def post_params
      params.require(:post).permit(:title, :content)
    end

end
