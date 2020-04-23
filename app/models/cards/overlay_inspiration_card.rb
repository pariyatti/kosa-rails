class OverlayInspirationCard < Card

  property :alignment, type: String, default: "overlay"
  property :text, type: String, default: ""
  
  property :image, type: String
  mount_uploader :image, ImageUploader

end
