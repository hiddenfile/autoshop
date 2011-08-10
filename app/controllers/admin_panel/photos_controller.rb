class AdminPanel::PhotosController < AdminPanel::AdminApplicationController
  def index
    @photos = Photo.paginate(:page => params[:page], :per_page => 20)
  end

  def destroy
    if Photo.find_by_id(params[:id]).try(:destroy)
      render :text => "true"
    else
      render :text => "false"
    end
  end

end
