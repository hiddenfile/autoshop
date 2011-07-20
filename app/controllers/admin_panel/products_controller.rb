class AdminPanel::ProductsController < AdminPanel::AdminApplicationController

  before_filter :find_product, :only => [:update, :show, :edit, :destroy]

  def create
    @product = Product.new(params[:product])
    photo_build

    if @product.save
      redirect_to(admin_panel_products_path, :notice => 'Product was successfully created.')
    else
      render :action => "new"
    end
  end

  def index
    @products = Product.includes(:company, :group).all
  end

  def new
    @product = Product.new
    @companies = Company.all
    @groups = Group.all
  end

  def update
    photo_build
    if @product.update_attributes(params[:product])
      redirect_to(admin_panel_product_path(@product), :notice => 'Product was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def show

  end

  def edit
    @companies = Company.all
    @groups = Group.all
  end

  def destroy
    @product.destroy
    redirect_to admin_panel_products_path, :notice => 'Product was successfully deleted.'
  end

  def delete_photo
    @product = Product.find(params[:product_id])
    @product.photos.find(params[:photo_id]).destroy
    render :text => true
  end

  private
  def find_product
    unless @product = Product.find_by_id(params[:id])
      flash[:error] = "Could not find id: #{params[:id]}"
      redirect_to admin_panel_products_path
    end

  end

  def photo_build
    params[:photos].each_value { |photo| @product.photos.build(photo) } if params[:photos]
  end
end
