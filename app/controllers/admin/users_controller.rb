class Admin::UsersController < Admin::AdminController
  def select
    @users = User.all
  end
end
