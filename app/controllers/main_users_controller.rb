class MainUsersController < ApplicationController
  def index
     @products = Product.order('status').where(:status => 'new').paginate(:per_page => 10, :page => params[:page])
  end
end