module CartMethods
  def self.check_or_create_cookie(cookies)
    unless cookies.has_key?(:cart_id) and cookies.has_key?(:count) and cookies.has_key?(:price)
      cookies[:cart_id] = { :value => Digest::MD5.hexdigest("#{Time.now} + #{Array.new(4){(65+rand(26)).chr}}"), :expires => 1.day.from_now }
      cookies[:count] = { :value => 0 , :expires => 1.day.from_now }
      cookies[:price] = { :value => 0 , :expires => 1.day.from_now }
      $redis.set(cookies[:cart_id],{})
      $redis.expire(cookies[:cart_id],1.day)
    end
    return get_cart_info(cookies)
  end

  def self.cookies_valid?(cookies)
    if cookies.has_key?(:cart_id) and cookies.has_key?(:count) and cookies.has_key?(:price)
      cookies[:cart_id] =~ /^[a-f0-9]{32}$/ and cookies[:count].to_i.to_s==cookies[:count]
    end
  end

  def self.set_cart_info(cookies,count,price)
    cookies[:count] = count.to_s
    cookies[:price] = price.to_s
  end

  def self.get_cart_info(cookies)
    return cookies[:count].to_i,cookies[:price].to_f
  end

  def self.get_items_list(cookies)
    items_list_decode($redis.get(cookies[:cart_id]))
  end

  def self.add_item_to_list(cookies,item_id,item_info)
    info = items_list_decode($redis.get(cookies[:cart_id]))

    unless info[item_id]
      info[item_id]=item_info
    else
      info[item_id]['count']=(info[item_id]['count'].to_i+1).to_s
    end

    $redis.set(cookies[:cart_id],items_list_code(info))

    cart_count,cart_price=check_or_create_cookie(cookies)
    set_cart_info(cookies,cart_count+1,cart_price+item_info[:price])
  end

  def self.remove_item_from_list(cookies,item_id)
    info = items_list_decode($redis.get(cookies[:cart_id]))

    if info[item_id]
      cart_count,cart_price=check_or_create_cookie(cookies)
      count = info[item_id]['count'].to_i
      set_cart_info(cookies,cart_count-count,cart_price-count*info[item_id]['price'].to_f)

      info.delete(item_id)

      $redis.set(cookies[:cart_id],items_list_code(info))
    end
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