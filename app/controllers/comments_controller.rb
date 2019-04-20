class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_back fallback_location: root_path
  end

  def destroy
    @comment = Comment.where(id: params[:id])
    @comment.destroy(params[:id])
    redirect_back fallback_location: root_path
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :user_id, :movie_id)
    end

end
