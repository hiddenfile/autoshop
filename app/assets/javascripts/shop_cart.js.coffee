@fVal = (id) ->
  return parseFloat($(id).html());


@procResultChange = (tr_id,inc,price,res) ->

  if $('#order_items_table').length!=0
    tr_id = '#order_items_row'+tr_id;

    change_count = fVal(tr_id+' > td.count_of_order_item')+parseFloat(inc);
    change_price = fVal(tr_id+' > td.price_of_order_item');

    $(tr_id+' > td.count_of_order_item').html(""+change_count);
    $(tr_id+' > td.sum_price_of_order_item').html((change_count*change_price).toFixed(1));

    n_price = parseFloat($('#order_common_price').html())+parseFloat(inc*change_price);

    $('#order_common_price').html(n_price.toFixed(1));
    $('#order_sum').html(n_price.toFixed(1));

  else
    if (res=="true")
      count = fVal('#order_pos_count')+1;
      $('#order_pos_count').html(""+count);

      if (count==1)
        $('.cart_control_links').show();

    n_price = fVal('#order_sum')+parseFloat(price);
    $('#order_sum').html(n_price.toFixed(1));


@addToCart = (product_id,inc,title,price) ->
  $.ajax
    type: "GET"
    url: "/shop_carts/"+product_id+"/add_to_cart"
    data: ({'inc' : inc, 'title' : title, 'price' : price})
    success: (response) ->
      procResultChange(product_id,inc,price,response);
      return false;


@procResultDel = (tr_id) ->
  tr_id = '#order_items_row'+tr_id;
  del_price = fVal(tr_id+' > td.sum_price_of_order_item');
  $(tr_id).remove();

  n_price = (fVal('#order_common_price')-del_price).toFixed(1);
  $('#order_common_price').html(n_price);
  $('#order_sum').html(n_price);

  count = $('#cart_table > tbody> tr.order_items_row').length;

  if (count==0)
    $('.cart_control_links').hide();

  $('#order_sum').html(n_price);
  $('#order_pos_count').html(""+count);


@deleteCartItem = (product_id) ->
  $.ajax
    type: "GET"
    url: "/shop_carts/"+product_id+"/remove_from_cart"
    data: ({})
    success: (response) ->
      if response=="true"
        procResultDel(product_id);
      return false;