class AdminPanel::AdminsController < AdminPanel::AdminApplicationController

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
       @admin = Admin.new(params[:admin])
       if @admin.save
           flash[:notice] = "Successful created"
             redirect_to admin_panel_admins_path
       else
         flash[:error] = "Error. Can not save."
         render :action => :new
       end
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def destroy
    Admin.find_by_id(params[:id]).try(:destroy)
    redirect_to(admin_panel_admins_path, :notice => 'Admin was successfully deleted.')
  end

end