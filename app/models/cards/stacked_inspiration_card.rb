class Cards::StackedInspirationCard < Card  
  property :text, type: String, default: ""
  
  property :image, type: String
  mount_uploader :image, ImageUploader

  def self.default_header
    "Inspiration of the Day"
  end

  def self.new_from_params(params)
    new_with_image(default_params(params))
  end
end
