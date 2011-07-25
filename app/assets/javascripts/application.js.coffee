@showCategory = (id) ->
  $(".category").hide()
  $(".category" + id).show()

@addToCart = (product_id) ->
  $.ajax
    type: "GET"
    url: "/products/"+product_id+"/add_to_cart"
    data: ({})
    success: (response) ->
      $('#cart_items').html(response);
      return false