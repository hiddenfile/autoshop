class AdminPanel::ProductsController < AdminPanel::AdminApplicationController

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
    @product = Product.find(params[:id])
    photo_build
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
    @product = Product.includes(:photos).find(params[:id])
    @companies = Company.all
    @groups = Group.all
  end

  def destroy
    if Product.find_by_id(params[:id]).try(:destroy)
       flash[:notice] = 'Product was successfully deleted.'
    else
      flash[:error] = 'Error.'
    end
    redirect_to admin_panel_products_path
  end

  def delete_photo
    @product = Product.find(params[:product_id])
    @product.photos.find(params[:photo_id]).destroy
    @product = Product.includes(:photos).find(params[:product_id])
    render :partial => "admin_panel/shared/images", :layout => false, :locals => {:target => @product, :target_link_ => "product"}
  end

  private

  def photo_build
    params[:photos].each_value { |photo| @product.photos.build(photo) } if params[:photos]
  end
end
