# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  belongs_to :genre
  has_many :comment

=begin
    before_save :valid_string?
    before_update :valid_string?

    private

    def valid_string?
      str = comment.title
      stack = []
      symbols = { '{' => '}', '[' => ']', '(' => ')' }
      str.each_char do |c|
        stack << c if symbols.key?(c)
        return false if symbols.key(c) && symbols.key(c) != stack.pop
      end
      stack.empty?
    end
=end

end
