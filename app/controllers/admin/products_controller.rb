class Admin::ProductsController < Admin::AdminController
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { render :nothing => true}
#          redirect_to(@comment, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
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
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

end
