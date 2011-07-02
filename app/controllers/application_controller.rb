class ApplicationController < ActionController::Base
  protect_from_forgery

  helper Handicraft::Helper
  
  def gollum
    Gollum::Wiki.new("/Users/xdite/Dropbox/projects/rails-102")
  end
  
end
