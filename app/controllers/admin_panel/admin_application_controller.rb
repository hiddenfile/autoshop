class AdminPanel::AdminApplicationController < ActionController::Base

  layout 'admin'
  before_filter :authenticate_admin!, :main_navigation_current_tab

  def main_navigation_current_tab
     @curr_path=request.env['PATH_INFO']
     end
end
