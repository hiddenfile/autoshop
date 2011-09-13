class AdminPanel::BackcallsController < AdminPanel::AdminApplicationController
  before_filter :find_backcall, :only => [:update, :destroy]

  def index
    @state=params['backcalls_type'] || "all"
    @backcalls = @state=="all" ?  Backcall.includes(:product).order('product_id asc') : Backcall.includes(:product).where("checked=?",@state=="checked")
    @backcalls=@backcalls.paginate(:page => params[:page], :per_page => 20)
    render :json => {:table => render_to_string(:partial => 'backcalls',:locals=>{:backcalls=>@backcalls, :state=>@state}), :paginate => render_to_string(:partial=>'paginate',:locals=>{:objects=>@backcalls})} if request.xhr?
  end

  def update
    render :text => @backcall.update_attributes(:checked=>params[:backcall_state]).to_s
  end

  def destroy
    if (@backcall.delete)
      render :text => "Deleted"
    else
      render :text => "Not deleted"
    end
  end

  protected
    def find_backcall
      @backcall=Backcall.find_by_id(params[:id])
      unless @backcall
        redirect_to :back
      end
    end
end
