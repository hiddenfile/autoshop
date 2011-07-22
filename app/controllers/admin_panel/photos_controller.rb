class AdminPanel::PhotosController < AdminPanel::AdminApplicationController
  def index
    @photos = Photo.all
  end

  def destroy
    if Photo.find_by_id(params[:id]).try(:destroy)
      render :text => "true"
    else
      render :text => "false"
    end
  end

end
