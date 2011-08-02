class SessionsController < Devise::SessionsController
  def new
    resource = build_resource
    clean_up_passwords(resource)
    render :template=>"/#{resource_name}s/sessions/new"
  end

  def create
    super
  end

  def update
    super
  end

end