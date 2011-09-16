function removeOrderItem(id,elem)
{
    $.ajax({
    type: "DELETE",
    url: "/admin_panel/order_items/"+id,
    success: function(response)
    {   if (response==='true')
        {
            jQuery(elem).parent().remove();
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
    {   if (response.state==true)
        {
            jQuery('.order_items').append(response.content);
        }
    }
    })
    return false;
}