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
    inc = params[:inc].to_i()
    count = $redis.hget(session[:session_id],params[:id]).to_i()


    count = 0 if count==nil
    if count+inc<0
      count = 0
    else
      count=count+inc
    end


    $redis.hset(session[:session_id],params[:id],count.to_s())
    render :template => 'products/add_to_cart', :layout => false
  end

  def remove_from_cart
    $redis.hdel(session[:session_id],params[:id])
    render :template => 'products/add_to_cart', :layout => false
  end

end
