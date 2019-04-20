require 'open-uri'

module MoviesHelper

  def internet_connection?
    begin
      true if open("http://www.google.com/")
    rescue
      false
    end
  end

end