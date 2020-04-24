class Cards::OverlayInspirationCard < Card
  property :alignment, type: String, default: "overlay"
  property :text, type: String, default: ""
  property :text_color, type: String, default: "black"
  
  property :image, type: String
  mount_uploader :image, ImageUploader

  def self.default_header
    "Inspiration of the Day"
  end

  def self.new_from_params(params)
    new_with_image(default_params(params))
  end
end
