class Artefacts::Excerpt < Artefacts::Document
  property :url, type: String
  property :reference, type: String
  property :content, type: String

  has_one :out, :author, type: :author, model_class: :"Metadata::Author"
  has_one :out, :audience, type: :audience, model_class: :"Metadata::Audience"
  has_one :out, :topic, type: :topic, model_class: :"Metadata::Topic"
end
