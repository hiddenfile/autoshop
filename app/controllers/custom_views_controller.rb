class CustomViewsController < ApplicationController
  def index
    @page = CustomViews.find_by_page_type(params[:page_type])
  end
end
