class AdminPanel::CustomViewsController < AdminPanel::AdminApplicationController
  before_filter :find_pages, :only => [:update, :show, :edit, :destroy]

  def index
    @search = CustomViews.search(params[:search] || {"meta_sort" => "id.asc"})
    @pages = @search.paginate(:page => params[:page], :per_page => 10)
  end

  def edit
    @page = CustomViews.find(params[:id])
  end

  def update
    @page.update_attributes(params[:custom_views])
    if @page.save
      flash[:notice] = "Page successfully updated"
      redirect_to admin_panel_custom_views_path(@pages)
    else
      flash[:error] = "Some ERROR here, perhaps you're doing something wrong )"
      render :action => :edit
    end
  end

  def show
    @page = CustomViews.find(params[:id])
  end

  def new
    @page= CustomViews.new
  end

  def create
    @page = CustomViews.new(params[:custom_views])
    if @page.save
      flash[:notice] = "Page successfully saved"
      redirect_to admin_panel_custom_views_path(@pages)
    else
      flash[:error] = "Some ERROR here, perhaps you're doing something wrong )"
      render :action => :new
    end
  end

  def destroy
    @page.destroy
    redirect_to admin_panel_custom_views_path, :notice => 'Product was successfully deleted.'
  end

  private

  def find_pages
    @page = CustomViews.find(params[:id])
  end
end
