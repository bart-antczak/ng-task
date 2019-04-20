module CommentsHelper

  def commented?
    Comment.exists?(user_id: current_user.id)
  end

end
