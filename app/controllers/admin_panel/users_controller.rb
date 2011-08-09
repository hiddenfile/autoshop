class AdminPanel::UsersController < AdminPanel::AdminApplicationController
  def index
    @search = User.search(params[:search] || {"meta_sort" => "id.asc"})
    @users = @search.all.paginate(:page => params[:page], :per_page => 20)
  end

  def destroy
    if User.find(params[:id]).destroy
      redirect_to(admin_panel_users_path, :notice => 'User was successfully deleted.')
    else
      redirect_to(admin_panel_users_path, :alert => 'Error.')
    end
  end
end
