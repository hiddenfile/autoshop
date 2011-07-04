class AdminPanel::AdminApplicationController < ActionController::Base

  layout 'admin'
  before_filter :authenticate_admin! if Admin.all.count>0

end
