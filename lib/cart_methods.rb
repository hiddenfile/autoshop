module CartMethods
  def self.check_or_create_cookie(cookies)
    unless cookies_valid?(cookies)
      cookies[:cart_id] = { :value => Digest::MD5.hexdigest("#{Time.now} + #{Array.new(4){(65+rand(26)).chr}}"), :expires => 1.day.from_now }
      $redis.set(cookies[:cart_id],{})
      $redis.expire(cookies[:cart_id],1.day)

      $redis.set(cookies[:cart_id]+'q',{'count'=>0, 'price'=>0}.to_json)
      $redis.expire(cookies[:cart_id]+'q',1.day)

    end
    get_cart_info(cookies)
  end

  def self.cookies_valid?(cookies)
    if cookies.has_key?(:cart_id) and $redis.get(cookies[:cart_id]+'q')
      cookies[:cart_id] =~ /^[a-f0-9]{32}$/
    end
  end

  def self.set_cart_info(cookies,count,price)
     $redis.set(cookies[:cart_id]+'q',{'count'=>count, 'price'=>price}.to_json)
  end

  def self.get_cart_info(cookies)
    list= items_list_decode($redis.get(cookies[:cart_id]+'q'))
    [list['count'].to_i,list['price'].to_f]
  end

  def self.get_items_list(cookies)
    items_list_decode($redis.get(cookies[:cart_id]))
  end

  def self.add_item_to_list(cookies,item_id,item_info)
    info = items_list_decode($redis.get(cookies[:cart_id]))

    unless info[item_id]
      info[item_id]=item_info
    else
      return false if info[item_id]['count'].to_i+item_info[:count]<0
      info[item_id]['count']=(info[item_id]['count'].to_i+item_info[:count]).to_s
    end

    $redis.set(cookies[:cart_id],items_list_code(info))

    cart_count,cart_price=check_or_create_cookie(cookies)
    set_cart_info(cookies,cart_count+item_info[:count],cart_price+item_info[:price]*item_info[:count])
    true
  end

  def self.remove_item_from_list(cookies,item_id)
    info = items_list_decode($redis.get(cookies[:cart_id]))

    if info[item_id]
      cart_count,cart_price=check_or_create_cookie(cookies)
      count = info[item_id]['count'].to_i

      set_cart_info(cookies,cart_count-count,cart_price-count*info[item_id]['price'].to_f)
      info.delete(item_id)

      $redis.set(cookies[:cart_id],items_list_code(info))
    else
      return false
    end
    true
  end

  def self.clear_cart(cookies)
    cookies.delete :cart_id
  end

  private
    def self.items_list_code(item)
      item.to_json
    end

    def self.items_list_decode(coded_item)
      ActiveSupport::JSON.decode(coded_item)
    end
end