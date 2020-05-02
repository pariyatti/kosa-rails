class User
  include Neo4j::ActiveNode
  include Neo4j::SaneTimestamps
  include Clearance::User

  property :email, type: String, default: ""
  property :encrypted_password, type: String, default: ""
  property :confirmation_token, type: String, default: ""
  property :remember_token, type: String, default: ""
  property :admin, type: Boolean, default: false
  
  validates :encrypted_password, presence: true, length: { maximum: 128 }
  validates :confirmation_token, length: { maximum: 128 }
  validates :remember_token, presence: true, length: { maximum: 128 }
  
end
