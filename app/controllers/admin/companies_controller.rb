class Admin::CompaniesController < Admin::AdminController
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { render :nothing => true}
#          redirect_to(@comment, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:company])
        format.html { redirect_to(@company, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

end
