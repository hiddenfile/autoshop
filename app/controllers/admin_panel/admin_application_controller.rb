class AdminPanel::AdminApplicationController < ActionController::Base

  layout 'admin'
  before_filter :authenticate_admin!
  helper_method :table_item_id

  protected
    def table_item_id(order_item)
      "order_item_"+order_item.id.to_s
    end
end
