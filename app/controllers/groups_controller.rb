class GroupsController < ApplicationController

  def show
    @group = Group.includes(:companies).find(params[:id])
  end

end