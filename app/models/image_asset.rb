
class ImageAsset < Asset
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :image, type: String
  mount_uploader :image, ImageUploader

  def url
    image.url
  end

  def filename
    image.file.path
  end
end
