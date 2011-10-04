class CompaniesController < ApplicationController
  def show
    @company = Company.includes(:groups).find(params[:id])
  end
end