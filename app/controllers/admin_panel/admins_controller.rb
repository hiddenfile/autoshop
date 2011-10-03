class AdminPanel::AdminsController < AdminPanel::AdminApplicationController

  before_filter :find_admin, :only => [:show, :destroy]

  def index
    @search = Admin.search(params[:search] || {"meta_sort" => "id.asc"})
    @admins = @search.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @admin = Admin.new
  end

  def create
       @admin = Admin.new(params[:admin])
       if @admin.save
          redirect_to(admin_panel_admins_path, :notice => "Successful created")
       else
         render :action => :new
       end
  end

  def show
  end

  def destroy
    @admin.try(:destroy)
    redirect_to(admin_panel_admins_path, :notice => 'Admin was successfully deleted.')
  end

  protected

  def find_admin
    @admin = Admin.find(params[:id])
  end

end