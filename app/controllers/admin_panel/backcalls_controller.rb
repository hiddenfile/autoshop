class AdminPanel::BackcallsController < AdminPanel::AdminApplicationController
  before_filter :find_backcall, :only => [:update, :destroy]

  def index
    @state=params['backcalls_type'] || "all"
    @backcalls = @state == "all" ?  Backcall.includes(:product).order('product_id asc') : Backcall.includes(:product).where(:checked => (@state=="checked"))
    @backcalls = @backcalls.paginate(:page => params[:page], :per_page => 20)
    render :json => {:table => render_to_string(:partial => 'backcalls',:locals => {:backcalls => @backcalls, :state => @state}), :paginate => render_to_string(:partial => 'paginate',:locals => {:objects => @backcalls})} if request.xhr?
  end

  def update
    render :json => {:state => @backcall.update_attributes(params[:backcall_attr])}
  end

  def destroy
    @backcall.delete
    render :json => {:state => true}
  end

  protected
    def find_backcall
      @backcall=Backcall.find_by_id(params[:id])
      unless @backcall
        redirect_to admin_panel_backcalls_path, :error => 'Item not found'
      end
    end
end
