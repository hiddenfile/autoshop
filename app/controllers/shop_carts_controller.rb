class ShopCartsController < ApplicationController
  def add_to_cart
    inc = params[:inc].to_i()
    count = $redis.hget(authcookie,params[:id]).to_i()

    product=Product.find(params[:id])

    if !$redis.hexists(product.id,'name')
      $redis.hset(product.id,'name',product.title)
      $redis.hset(product.id,'price',product.price==nil ? 0 : product.price.price)

#      $redis.expire(product.id, 1.day)
    end

    count = 0 if count==nil
    count = (count+inc<0) ? 0 : count+inc

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
  end

  def show
  end
end