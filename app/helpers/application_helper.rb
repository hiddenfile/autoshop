module ApplicationHelper
  def CheckCart
     $redis.hlen(session[:session_id])
  end
end
