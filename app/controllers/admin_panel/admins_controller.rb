class AdminPanel::AdminsController < AdminPanel::AdminApplicationController

  def index
    @admins = Admin.all
  end

  def destroy
    if Admin.find(params[:id]).destroy
      redirect_to(admin_panel_admins_path, :notice => 'Admin was successfully deleted.')
    else
      redirect_to(admin_panel_admins_path, :notice => 'Error.')
    end
  end

end