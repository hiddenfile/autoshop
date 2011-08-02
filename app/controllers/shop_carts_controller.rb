class ShopCartsController < ApplicationController
  def add_to_cart
    inc = params[:inc].to_i()
    count = $redis.hget(authcookie,params[:id]).to_i()

    if !$redis.hexists(params[:id],'name')
      $redis.hset(params[:id],'name',params[:title])
      $redis.hset(params[:id],'price',params[:price])

#      $redis.expire(product.id, 1.day)
    end

    count = 0 if count==nil
    count = (count+inc<0) ? 0 : count+inc

    res=$redis.hset(authcookie,params[:id],count.to_s())
    render :text => res.to_s()
  end

  def remove_from_cart
    @res = $redis.hdel(authcookie,params[:id])
    render :text => @res>0 ? "true" : "false"
  end

  def show
  end

  def destroy
    RedisMethods.clear_cart(authcookie)
    redirect_to root_path
  end
end