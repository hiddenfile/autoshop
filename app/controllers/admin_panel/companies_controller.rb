class AdminPanel::CompaniesController < AdminPanel::AdminApplicationController
  def create
    @company = Company.new(params[:company])

    if params[:photos]
      params[:photos].each do |hash|
        @company.photos.build(:photo => hash)
      end
    end

    if @company.save
      redirect_to(admin_panel_companies_path, :notice => 'Company was successfully created.')
    else
      render :action => "new"
    end
  end

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
    @photo = Photo.new
  end

  def update
    @company = Company.find(params[:id])

    if params[:photos]
      params[:photos].each do |hash|
        @company.photos.build(:photo => hash)
      end
    end

    if @company.update_attributes(params[:company])
      redirect_to(admin_panel_company_path(@company), :notice => 'Company was successfully updated.')
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

  def destroy
    if Company.find(params[:id]).destroy
      redirect_to(admin_panel_companies_path, :notice => 'Company was successfully deleted.')
    else
      redirect_to(admin_panel_companies_path, :alert => 'Error.')
    end
  end

  def delete_photo
    @company = Company.find(params[:company_id])
    @company.photos.find(params[:photo_id]).destroy
    @company = Company.includes(:photos).find(params[:company_id])
    render :partial => "admin_panel/shared/images", :layout => false, :locals => {:target => @company, :target_link_ => "company"}
  end

end
