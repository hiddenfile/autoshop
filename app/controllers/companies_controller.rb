class CompaniesController < ApplicationController

  def show
    @company = Company.includes(:group).find(params[:id])
  end

end