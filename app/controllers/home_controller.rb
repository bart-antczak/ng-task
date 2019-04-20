class HomeController < ApplicationController

  def welcome
    @commenters = User.joins(:comment)
                      .group('user_id')
                      .where('comments.created_at > ?', 7.days.ago)
                      .count
                      .sort_by { |x, y| [ -Integer(y), x ] }
                      .first(10)
  end

end
