class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'Your comment was added'
    else
      flash[:error] = @comment.errors.full_messages[0] || 'Comment adding failed'
    end
    redirect_to movie_path(@comment.movie)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.can_be_destroyed_by?(current_user)
      @comment.destroy
      flash[:notice] = 'Your comment was deleted'
    end

    redirect_to movie_path(@comment.movie)
  end

  private

  def comment_params
    params.require(:comment).permit(:movie_id, :content)
  end

end
