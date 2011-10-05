function removeOrderItem(id, elem)
{
    $.ajax({
    type: "DELETE",
    url: "/admin_panel/order_items/" + id,
    success: function(response)
    {   if (response.state == true) {
            jQuery(elem).parent().parent().remove();
            jQuery('#order_summary').html(response.summary);
        }
    }
    })
    return false;
}

function addOrderItem(order_id)
{
    $.ajax({
    type: "POST",
    url: "/admin_panel/order_items/",
    data:({'order_id' : order_id,'product_id' : jQuery('#products').attr('value')}),
    success: function(response)
    {
        if (response.state != null)
        {
            if (response.state == 'add') {
                jQuery('.items_table > tbody').append(response.content);
            }

            if (response.state == 'update') {
                jQuery('#'+response.updated_id).attr('value',response.count);
                jQuery('#'+response.updated_id).removeAttr('style');
            }

            jQuery('#order_summary').html(response.summary);
        }
    }
    })
    return false;
}

function checkValue(elem)
{
    var elem_node = jQuery(elem);
    var count_val = elem_node.attr('value');
    var int_count_val = parseInt(count_val);

    if (int_count_val < 0 || ("" + int_count_val) != count_val) {
        elem_node.css('background-color', '#FF0000');
        return false;
    }
    else if (int_count_val == 0) {
        elem_node.css('background-color', '#FFFF00');
    }
    else {
        elem_node.removeAttr('style');
    }

    return true;
}

function changeState(id, new_state, auth)
{
    $.ajax({
    type: "POST",
    url: "/admin_panel/orders/" + id,
    data: {'order_attr' : {'order_state' : new_state}, 'authenticity_token': auth, '_method' : 'PUT'},
    success: function(response)
    {   if (response) {

        }
    }
    })
    return false;
}

function changeItemCount(id, count, auth)
{
    $.ajax({
    type: "POST",
    url: "/admin_panel/order_items/" + id,
    data: {'order_item' : {'count' : count}, 'authenticity_token': auth, '_method' : 'PUT'},
    success: function(response)
    {   if (response.state) {
            jQuery('#order_summary').html(response.summary);
        }
    }
    })
    return false;
}