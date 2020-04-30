class Metadata::AuthorsController < ApplicationController
  def index
    @authors = Metadata::Author.all 
  end
end
