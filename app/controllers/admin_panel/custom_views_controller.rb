class AdminPanel::CustomViewsController < AdminPanel::AdminApplicationController
  before_filter :find_pages, :only => [:update, :show, :edit, :destroy]
  before_filter :build_path, :only => [:update, :create, :destroy]

  def index
    @search = CustomViews.search(params[:search] || {"meta_sort" => "id.asc"})
    @pages = @search.paginate(:page => params[:page], :per_page => 10)
  end

  def edit
  end

  def update
    File.open(@template_path, 'w') {|file| file.write (params[:custom_views][:page_content]) } if params[:custom_views][:page_type] == 'static'
    if @page.update_attributes(params[:custom_views])
      redirect_to admin_panel_custom_views_path(@pages), :notice => "Page successfully updated"
    else
      render :action => :edit
    end
  end

  def show
  end

  def new
    @page = CustomViews.new
  end

  def create
    File.open(@template_path, 'w') {|file| file.write (params[:custom_views][:page_content]) } if (params[:custom_views][:page_type] == 'static')
    @page = CustomViews.new(params[:custom_views])
    if @page.save
      redirect_to admin_panel_custom_views_path, :notice => "Page successfully saved"
    else
      render :action => :new
    end
  end

  def destroy
    File.delete(@template_path) if File.exist?(@template_path)
    @page.destroy
    redirect_to admin_panel_custom_views_path, :notice => 'Page was successfully deleted.'
  end

  private

  def build_path
    part = params.has_key?('custom_views') ? params[:custom_views][:page_name] : @page.page_name
    @template_path = "#{Rails.root}/app/views/staticpages/"+part+".html"
  end

  def find_pages
    @page = CustomViews.find(params[:id])
    redirect_to(admin_panel_custom_views_path, :error => 'Item not found') unless @page
  end
end