class AdminPanel::GroupsController < AdminPanel::AdminApplicationController
  before_filter :find_group, :only => [:update, :show, :edit, :destroy]

  def create
    @group = Group.new(params[:group])
    photo_build
    if @group.save
      redirect_to(admin_panel_groups_path, :notice => 'Group was successfully created.')
    else
      render :action => "new"
    end
  end

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def update
    photo_build
    if @group.update_attributes(params[:group])
      redirect_to(admin_panel_group_path(@group), :notice => 'Group was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @group.destroy
    redirect_to(admin_panel_groups_path, :notice => 'Group was successfully deleted.')
  end


  def delete_photo
    @group = Group.find(params[:group_id])
    @group.photos.find(params[:photo_id]).destroy
    @group = Group.includes(:photos).find(params[:group_id])
    render :partial => "admin_panel/shared/images", :layout => false, :locals => {:target => @group, :target_link_ => "group"}
  end

  private
  def find_group
    unless @group = Group.find_by_id(params[:id])
      flash[:error] = "Could not find id: #{params[:id]}"
      redirect_to admin_panel_groups_path
    end
  end

  def photo_build
    params[:photos].each_value { |photo| @group.photos.build(photo) } if params[:photos]
  end

end
