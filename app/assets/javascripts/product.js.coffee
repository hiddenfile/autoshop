@fVal = (id) ->
  return parseFloat($(id).html());

@addToCart = (product_id,inc,title,price) ->
  $.ajax
    type: "PUT"
    url: "/shop_carts/"+product_id
    data: ({'title' : title, 'price' : price})
    success: (response) ->
      procResultChange(product_id,inc,price,response);
      return false;

@deleteCartItem = (product_id) ->
  $.ajax
    type: "PUT"
    url: "/shop_carts/"+product_id
    data: ({'delete_item' : '1'})
    success: (response) ->
      if response=="true"
        procResultDel(product_id);
      return false;


@procResultDel = (tr_id) ->
  tr_id = '#order_items_row'+tr_id;
  del_price = fVal(tr_id+' > td.sum_price_of_order_item');
  del_count = fVal(tr_id+' > td.count_of_order_item');

  $(tr_id).remove();

  n_price = (fVal('#order_common_price')-del_price).toFixed(1);
  $('#order_common_price').html(n_price);
  $('#order_sum').html(n_price);

  if ($('#cart_table > tbody> tr.order_items_row').length==0)
    $('.cart_control_links').hide();

  $('#order_sum').html(n_price);
  $('#order_pos_count').html(""+(fVal('#order_pos_count')-del_count));




@procResultChange = (tr_id,inc,price,res) ->

  tr_id = '#order_items_row'+tr_id;
  inc = parseFloat(inc)
  price=parseFloat(price)

  change_count = fVal(tr_id+' > td.count_of_order_item')+inc;
  $(tr_id+' > td.count_of_order_item').html(""+change_count);
  $(tr_id+' > td.sum_price_of_order_item').html((change_count*price).toFixed(1));

  console.log(fVal('#order_common_price'))
  n_price = fVal('#order_sum')+inc*price;
  $('#order_sum').html(n_price.toFixed(1));

  count = fVal('#order_pos_count')+inc;
  $('#order_pos_count').html(""+count);

  $('#order_common_price').html(n_price.toFixed(1));
