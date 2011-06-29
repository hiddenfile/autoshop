class AdminPanel::AdminsController < AdminPanel::AdminApplicationController

  def index
    @admins = Admin.all
  end

end