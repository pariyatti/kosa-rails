
class Artefacts::Audio < Artefact
  property :audio, type: String
  mount_uploader :audio, AudioUploader

  def url
    audio.url
  end

  def filename
    audio.file.path
  end
end
