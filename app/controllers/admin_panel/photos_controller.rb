class AdminPanel::PhotosController < ApplicationController
  def index
    @photo = Photo.all
  end

  def destroy
    if Photo.find_by_id(params[:id]).try(:destroy)
      render :text => "true"
    else
      render :text => "false"
    end
  end

end
