class BackcallsController < ApplicationController

  def create
    if simple_captcha_valid?
      backcall = Backcall.new(:author=>user_signed_in? ? current_user.email : "Anonimous", :content => params[:text], :product_id => params[:product_id])
      if backcall.save
        render :json => {:backcall => render_to_string(:partial => 'products/backcall', :locals=>{:backcall => backcall}), :captcha => render_to_string(:partial => "products/captcha")}
      else
        render :json => {:errors => backcall.errors, :captcha => render_to_string(:partial => "products/captcha")}
      end
    else
      render :json => {:errors => "Captcha is wrong", :captcha => render_to_string(:partial => "products/captcha")}
    end
  end

  def index
    @backcalls = Backcall.order('product_id asc').paginate(:page => params[:page], :per_page => 20)
  end
end
