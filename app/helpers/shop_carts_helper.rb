module ShopCartsHelper
  def order_summ()
    items = $redis.hgetall(@authcookie)
    keys = $redis.hkeys(@authcookie)
    price=0

    keys.each do |key|
      curr_price = $redis.hget(key,'price').to_f()*items[key].to_i()
      price=price+curr_price
    end
    price.to_s()
  end
end