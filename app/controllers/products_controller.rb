class ProductsController < ApplicationController

  def index
    @company = Company.find(params[:company_id])
    @group = Group.find(params[:group_id])
    @products = Product.includes(:company,:group).where(:company_id => params[:company_id], :group_id => params[:group_id]).order('title DESC').all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    count = $redis.hget(session[:session_id],params[:id]).to_i()
    $redis.hset(session[:session_id],params[:id],(count==nil ? 1 : count+1).to_s())

#    render :text => "true"
    render :template => 'products/add_to_cart', :layout => false
  end

end
