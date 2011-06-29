class Admin::UsersController < Admin::AdminsController
  def index
    @users = User.all
  end
end
