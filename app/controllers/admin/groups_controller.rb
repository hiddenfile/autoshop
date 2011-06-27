class Admin::GroupsController < Admin::AdminController
  def create
    @group = Group.new(params[:product])

    respond_to do |format|
      if @group.save
        format.html { render :nothing => true}
#          redirect_to(@comment, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
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

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to(@group, :notice => 'group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @group = group.find(params[:id])
  end

  def edit
    @group = group.find(params[:id])
  end

end
