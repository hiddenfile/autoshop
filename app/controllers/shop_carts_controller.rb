class ShopCartsController < ApplicationController
  def add_to_cart
    inc = params[:inc].to_i()
    count = $redis.hget(authcookie,params[:id]).to_i()

    product=Product.find(params[:id])

    if !$redis.hexists(product.id,'name')
      $redis.hset(product.id,'name',product.title)
      $redis.hset(product.id,'price',product.price==nil ? 0 : product.price.price)
    end

    count = 0 if count==nil
    if count+inc<0
      count = 0
    else
      count=count+inc
    end

    $redis.hset(authcookie,params[:id],count.to_s())
  end

  def add_to_cart_update_cart_and_table
    add_to_cart()
    render :text => "true"
  end

  def add_to_cart_update_cart
    add_to_cart()
    render :template => 'shop_carts/shop_cart_info', :layout => false
  end

  def remove_from_cart
    @res = $redis.hdel(authcookie,params[:id])
    render :text => @res>0 ? "true" : "false"

#    render :text => redis_to_json
  end

  def cart_items
  end

  def redis_to_json

    retstr="{ \"items\": ["

    items = $redis.hgetall(@authcookie)
    keys = $redis.hkeys(@authcookie)

    keys.each do |key|
     curr_price = $redis.hget(key,'price').to_f()*items[key].to_i()

     retstr+="{"
       retstr+="\"name\" : \"#{$redis.hget(key,'name')}\","
       retstr+="\"count\" : \"#{items[key]}\","
       retstr+="\"price\" : \"#{curr_price.to_s()}\""
       retstr+="},"
    end

    retstr=retstr[0,retstr.length-1]+"]}"
  end
end