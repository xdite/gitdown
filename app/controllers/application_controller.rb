class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  def gollum
    Gollum::Wiki.new("/Users/xdite/Dropbox/projects/rails-102")
  end
  
end
