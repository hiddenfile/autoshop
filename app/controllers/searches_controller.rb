class SearchesController < ApplicationController

  def search_by_products
    @search_req = params[:search][:req].gsub('%','\%').gsub('_','\_')
    @products = Product.includes(:company,:group,:photos).where("lower(title) like ?" , "%#{@search_req.downcase}%").all
  end
end