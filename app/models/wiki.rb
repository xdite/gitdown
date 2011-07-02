class Wiki
  include ActiveModel::AttributeMethods

  attr_accessor :name
  attr_accessor :content
  
  DATA = Gollum::Wiki.new("/Users/xdite/Dropbox/projects/rails-102")

  def initialize(attributes = {})
    if attributes.present?
      attributes.each { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end
  end
  
  def self.find(id)
    DATA.page(id)
  end

end
