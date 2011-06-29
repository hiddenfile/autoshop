class AdminPanel::UsersController < AdminPanel::AdminApplicationController
  def index
    @users = User.all
  end
end
