class AdminPanel::UsersController < AdminPanel::AdminApplicationController
  def index
    @users = User.all
  end

  def destroy
    if User.find(params[:id]).destroy
      redirect_to(admin_panel_users_path, :notice => 'User was successfully deleted.')
    else
      redirect_to(admin_panel_users_path, :alert => 'Error.')
    end
  end
end
