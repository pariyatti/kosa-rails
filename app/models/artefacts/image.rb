
class Artefacts::Image < Artefact
  property :image, type: String
  mount_uploader :image, ImageUploader

  def url
    image.url
  end

  def filename
    image.file.path
  end
end
