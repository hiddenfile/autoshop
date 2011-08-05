class ProductsController < ApplicationController

  def index
    @company = Company.find(params[:company_id])
    @group = Group.find(params[:group_id])
    @products = Product.includes(:company,:group).where(:company_id => params[:company_id], :group_id => params[:group_id]).order('title DESC').all
  end

  def show
    @product = Product.find(params[:id])
  end
end
