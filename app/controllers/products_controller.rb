class ProductsController < ApplicationController
  def create
    @product = Product.new(params[:product])

    if @product.save
      redirect_to(admin_panel_products_path, :notice => 'Product was successfully created.')
    else
      render :action => "new"
    end
  end

  def index
    @products = Product.includes(:company,:group).all

  end

  def new
    @product = Product.new
    @companies = Company.all
    @groups = Group.all

  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to(admin_panel_product_path(@product), :notice => 'Product was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])

    @companies = Company.all
    @groups = Group.all
  end
end
