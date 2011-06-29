class Admin::AdminController < ActionController::Base
  layout "admin"

  def index
    @admins = Admin.all
  end
end