class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @word = params[:word]
    @method = params[:method]

    if @model == 'user'
			@q = User.search_for(@word, @method)
		else
			@q = Book.search_for(@word, @method)
    end
  end

end
