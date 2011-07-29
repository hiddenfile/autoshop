@showCategory = (id) ->
  $(".category").hide()
  $(".category" + id).show()

@fVal = (id) ->
  return parseFloat($(id).html());

@procResultDel = (tr_id) ->
  tr_id = '#order_items_row'+tr_id;
  del_price = fVal(tr_id+' > td.sum_price_of_order_item');
  $(tr_id).remove();

  n_price = ""+(fVal('#order_common_price')-del_price);
  $('#order_common_price').html(n_price);
  $('#order_sum').html(n_price);

  $('#order_sum').html("Сумма : "+n_price);

  $('#order_pos_count').html("Позиций : "+$('#cart_table > tbody> tr.order_items_row').length);


@procResultChange = (tr_id,inc) ->
  tr_id = '#order_items_row'+tr_id;

  change_count = fVal(tr_id+' > td.count_of_order_item')+parseFloat(inc);
  change_price = fVal(tr_id+' > td.price_of_order_item');

  $(tr_id+' > td.count_of_order_item').html(""+change_count);
  $(tr_id+' > td.sum_price_of_order_item').html(""+(change_count*change_price));

  n_price = parseFloat($('#order_common_price').html())+(inc*change_price);

  $('#order_common_price').html(""+n_price);
  $('#order_sum').html("Сумма : "+n_price);


@addToCartTC = (product_id,inc) ->
  $.ajax
    type: "GET"
    url: "/shop_carts/"+product_id+"/add_to_cart_update_cart_and_table"
    data: ({'inc' : inc})
    success: (response) ->
      if response=="true"
        procResultChange(product_id,inc);
      return false;

@addToCartC = (product_id,inc) ->
  $.ajax
    type: "GET"
    url: "/shop_carts/"+product_id+"/add_to_cart_update_cart"
    data: ({'inc' : inc})
    success: (response) ->
      $('#cart_info').html(response);
      return false;

@deleteCartItem = (product_id) ->
  $.ajax
    type: "GET"
    url: "/shop_carts/"+product_id+"/remove_from_cart"
    data: ({})
    success: (response) ->
      if response=="true"
        procResultDel(product_id);
      return false;