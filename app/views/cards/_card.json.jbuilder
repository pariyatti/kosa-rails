json.extract! card, :id, :type, :flag, :bookmarkable, :shareable, :title, :header, :image, :text, :created_at, :updated_at
json.url card_url(card, format: :json)
