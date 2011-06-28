class Admin::CompaniesController < Admin::AdminController
  def create
    @company = Company.new(params[:company])

      if @company.save
         redirect_to(admin_companies_path, :notice => 'Company was successfully created.')
      else
         render :action => "new"
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

      if @company.update_attributes(params[:company])
        redirect_to(admin_company_path(@company), :notice => 'Product was successfully updated.')
      else
        render :action => "edit"
      end
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

end
