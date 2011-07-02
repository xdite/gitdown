class Wiki
  include ActiveModel::AttributeMethods

  attr_accessor :name, :raw_data, :formatted_data
  
  DATA = Gollum::Wiki.new("/Users/xdite/Dropbox/projects/rails-102")

  def initialize(attributes = {})
    if attributes.present?
      attributes.each { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end
  end
  
  def self.find(name)
    data = DATA.page(name)
    if data
      new :name => data.name, :raw_data => data.raw_data, :formatted_data => data.formatted_data
    end
  end
  
  def update_attributes(hash)
    name = hash[:name]
    raw_data = hash[:raw_data]
    data = DATA.page(name)
    DATA.update_page(data, name,:markdown, raw_data)
  end
  
  def save
    DATA.write_page(name, :markdown, raw_data)
  end
  
end
