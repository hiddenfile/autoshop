@showCategory = (id) ->
  $(".category").hide()
  $(".category" + id).show()

@addToCart = (product_id,inc) ->
  $.ajax
    type: "GET"
    url: "/shop_carts/"+product_id+"/add_to_cart"
    data: ({'inc' : inc})
    success: (response) ->
      $('#cart_info').html(response);
      return false

@deleteCartItem = (product_id) ->
  $.ajax
    type: "GET"
    url: "/shop_carts/"+product_id+"/remove_from_cart"
    data: ({})
    success: (response) ->
      $('#cart_info').html(response);
      return false