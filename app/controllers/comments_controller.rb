class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = "Comment posted."
          redirect_to @post
        end
        format.js
      end
    else
      render :js => "alert('error saving comment');"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Comment deleted.'
        redirect_to @post
      end
      format.js # JavaScript response
    end
  end

  def upvote
    @comment = Comment.find(params[:id])
    @vote = @comment #ajax purposes
    if @comment.upvote!(current_user).save
      respond_to do |format|
        format.html do
          flash[:success] = "Upvoted!"
          redirect_to(:back)
        end
        format.js
      end
    end
  end

  def downvote
    @comment = Comment.find(params[:id])
    @vote = @comment
    if @comment.downvote!
      respond_to do |format|
        format.html do
          flash[:success] = "Upvoted!"
          redirect_to(:back)
        end
        format.js { render :action => "upvote" }
      end
    end
  end

  def reply_box
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def reply_post
    @comment = Comment.initialize_reply(params[:content], params[:id], current_user.id)
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = "Reply posted!"
          redirect_to(:back)
        end
        format.js
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
