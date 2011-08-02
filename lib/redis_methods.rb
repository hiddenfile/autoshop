module RedisMethods

  def self.clear_cart(authcookie)
    keys = $redis.hkeys(authcookie)

    keys.each do |key|
      $redis.hdel(authcookie,key)
    end
  end
end
