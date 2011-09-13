class ProductsController < ApplicationController
  before_filter :preinit

  def index
    @products = Product.includes(:company,:group).where(:company_id => params[:company_id], :group_id => params[:group_id]).order('title DESC').all
  end

  def show
    @product = Product.includes(:backcalls).find(params[:id])
  end

  protected

  def preinit
    @company = Company.find(params[:company_id])
    @group = Group.find(params[:group_id])
  end

end
