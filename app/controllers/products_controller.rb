class ProductsController < ApplicationController

  def index
    @products = Product.includes(:company,:group).all
  end

  def show
    @product = Product.find(params[:id])
  end

end
