class Admin::GroupsController < Admin::AdminController
  def create
    @group = Group.new(params[:group])

      if @group.save
        redirect_to(admin_groups_path, :notice => 'Group was successfully created.')
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

      if @group.update_attributes(params[:group])
        redirect_to(admin_group_path(@group), :notice => 'group was successfully updated.')
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

end
