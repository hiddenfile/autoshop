class Admin::AdminsController < ActionController::Base
  layout "admin"

  def index
    @admins = Admin.all
  end

end