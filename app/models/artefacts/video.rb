
class Artefacts::Video < Artefact
  property :video, type: String
  mount_uploader :video, VideoUploader

  def url
    video.url
  end

  def filename
    video.file.path
  end
end
