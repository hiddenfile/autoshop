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
    if (params[:custom_views][:page_type]=='static')
      @page.update_attributes(params[:custom_views])
      File.open("#{Rails.root}/app/views/staticpages/"+params[:custom_views][:page_name]+".html", 'w') {|file| file.write (params[:custom_views][:page_content]).to_s }
      if @page.save
        flash[:notice] = "Page successfully updated"
        redirect_to admin_panel_custom_views_path(@pages)
      else
        flash[:error] = "Some ERROR here, perhaps you're doing something wrong )"
        render :action => :edit
      end
    else
      @page.update_attributes(params[:custom_views])
      if @page.save
        flash[:notice] = "Page successfully updated"
        redirect_to admin_panel_custom_views_path(@pages)
      else
        flash[:error] = "Some ERROR here, perhaps you're doing something wrong )"
        render :action => :edit
      end
    end
  end

  def show
    @page = CustomViews.find(params[:id])
  end

  def new
    @page= CustomViews.new
  end

  def create
    if (params[:custom_views][:page_type]=='static')
      File.open("#{Rails.root}/app/views/staticpages/"+params[:custom_views][:page_name]+".html", 'w') {|file| file.write (params[:custom_views][:page_content]).to_s }
      @page = CustomViews.new(params[:custom_views])
      if @page.save
        redirect_to admin_panel_custom_views_path(@pages), :notice => "Page successfully saved"
      else
        render :action => :new, :error => "Some ERROR here, perhaps you're doing something wrong )"
      end
    else
      @page = CustomViews.new(params[:custom_views])
      if @page.save
        redirect_to admin_panel_custom_views_path(@pages), :notice => "Page successfully saved"
      else
        render :action => :new, :error => "Some ERROR here, perhaps you're doing something wrong )"
      end
    end
  end

  def destroy
    File.delete("#{Rails.root}/app/views/staticpages/"+@page.page_name+".html") if File.exist?("#{Rails.root}/app/views/staticpages/"+@page.page_name+".html")
    @page.destroy
    redirect_to admin_panel_custom_views_path, :notice => 'Page was successfully deleted.'
  end

  private

  def find_pages
    @page = CustomViews.find(params[:id])
  end
end
