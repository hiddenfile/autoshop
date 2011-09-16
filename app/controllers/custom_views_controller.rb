class CustomViewsController < ApplicationController
  def index
    @page = CustomViews.find_by_page_name(params[:page_name])
  end
end
