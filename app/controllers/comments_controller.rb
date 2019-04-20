class CommentsController < ApplicationController

  def create
    respond_to do |format|
      format.js {
        @comment = Comment.new(comment_params)
        @comment.save
        @comments = Comment.all
      }
    end
  end

  def destroy
    respond_to do |format|
      format.js {
        @comment = Comment.where(id: params[:id])
        @comment.destroy(params[:id])
        @comments = Comment.all
      }
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :user_id, :movie_id)
    end

end
