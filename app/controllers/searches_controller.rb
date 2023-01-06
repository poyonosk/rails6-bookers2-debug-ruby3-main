class SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :search

  def search
    @q = User.ransack(params[:q])
  end

  def result
    @users = @q.result(distinct: true)
  end

end
