class Admin::ProductsController < Admin::AdminController
  def create

#    user=User.find_by_name(params[:post][:user][:user])
#
#    @post=user.posts.build
#    %w(title body).each do |attr|
#      @post.send("#{attr}=",params[:post][attr])
#    end

#    params[:product][:company]=Company.find_by_name(params[:product][:company]).id
#    params[:product][:group]=Group.find_by_name(params[:product][:group]).id

#    params[:product][:company]=Company.find(params[:product][:company])
#    params[:product][:group]=Group.find(params[:product][:group])

    @product = Product.new(params[:product])

      if @product.save
        redirect_to(admin_products_path, :notice => 'Product was successfully created.')
      else
        render :action => "new"
      end
  end

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @companies = Company.all
    @groups = Group.all
  end

  def update
    params[:product][:company]=Company.find(params[:product][:company])
    params[:product][:group]=Group.find(params[:product][:group])

    @product = Product.find(params[:id])

      if @product.update_attributes(params[:product])
        redirect_to(admin_product_path(@product), :notice => 'Product was successfully updated.')
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
