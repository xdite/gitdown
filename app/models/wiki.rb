class Wiki
  include ActiveModel::AttributeMethods

  attr_accessor :name
  attr_accessor :content

  def initialize(attributes = {})
    if attributes.present?
      attributes.each { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end
  end

end
