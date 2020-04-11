
class ImageAsset < Asset
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :image, type: String
  mount_uploader :image, ImageUploader

  def url
    # HACK: necessary because the carrierwave-neo4j gem is broken
    #       - gem is vendored so we can fix it, eventually -sd
    filename = self.query_as(:i) # This gives us our first Query object
      .match("(i:ImageAsset {uuid: '#{uuid}'})")
      .pluck("i.image")
      .first

    "/#{image.store_dir}/#{filename}"
  end
end
