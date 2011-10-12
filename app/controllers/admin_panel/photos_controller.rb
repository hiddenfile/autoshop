class AdminPanel::PhotosController < AdminPanel::AdminApplicationController
  def index
    @photos = Photo.paginate(:page => params[:page], :per_page => 20)
  end

  def destroy
    render :json => {:state => (Photo.find_by_id(params[:id]).try(:destroy) != nil)}
  end

end
