
# top-level type in the hierarchy; don't create these directly
class ImageAsset < Asset
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :image, type: String
  mount_uploader :image, ImageUploader

  def url
    # HACK: necessary because the carrierwave-neo4j gem is broken
    filename = self.query_as(:i) # This gives us our first Query object
      .match("(i:ImageAsset {uuid: '#{uuid}'})")
      .pluck("i.image")
      .first

    "/#{image.store_dir}/#{filename}"
  end
end
