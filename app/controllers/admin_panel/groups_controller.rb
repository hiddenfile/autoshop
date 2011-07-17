class AdminPanel::GroupsController < AdminPanel::AdminApplicationController
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
    @group = Group.find(params[:id])
    photo_build
    if @group.update_attributes(params[:group])
      redirect_to(admin_panel_group_path(@group), :notice => 'Group was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

    def destroy
    if Group.find(params[:id]).destroy
      redirect_to(admin_panel_groups_path, :notice => 'Group was successfully deleted.')
    else
      redirect_to(admin_panel_groups_path, :alert => 'Error.')
    end
  end


  def delete_photo
    @group = Group.find(params[:group_id])
    @group.photos.find(params[:photo_id]).destroy
    @group = Group.includes(:photos).find(params[:group_id])
    render :partial => "admin_panel/shared/images", :layout => false, :locals => {:target => @group, :target_link_ => "group"}
  end

  private

  def photo_build
    params[:photos].each_value { |photo| @group.photos.build(photo) } if params[:photos]
  end

end
