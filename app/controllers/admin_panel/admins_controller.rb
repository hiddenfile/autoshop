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
         flash[:alert] = "Error. Can not save."
         render :action => :new
       end
  end

  def destroy
    if Admin.find(params[:id]).destroy
      redirect_to(admin_panel_admins_path, :notice => 'Admin was successfully deleted.')
    else
      redirect_to(admin_panel_admins_path, :alert => 'Error.')
    end
  end

end