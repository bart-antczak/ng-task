module CommentsHelper

  def commented?(movie_id)
    Comment.exists?(movie_id: movie_id, user_id: current_user.id)
  end

end
