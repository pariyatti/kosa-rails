class Metadata::AuthorsController < LibraryController
  before_action :require_login
  
  def index
    @authors = Metadata::Author.all 
  end
end
