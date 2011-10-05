function deleteBackcall(id,elem)
{
    $.ajax({
    type: "POST",
    url: "/admin_panel/backcalls/"+id,
    data: ({'_method' : 'DELETE', 'authenticity_token' : $("meta[name='csrf-token']").attr('content') }),
    success: function(response)
    {   if (response.state) {
            $(elem).parent().parent().remove();
        }
    }
    })
    return false;
}

function change_stateBackcall(id,elem)
{
    var chState = jQuery(elem).attr('checked') || "unchecked";
    chState = (chState == 'checked' ? 'true' : 'false');

    $.ajax({
    type: "POST",
    url: "/admin_panel/backcalls/"+id,
    data: ({'backcall_attr' : { 'checked' : chState}, '_method' : 'PUT', 'authenticity_token' : $("meta[name='csrf-token']").attr('content')}),
    success: function(response){
        if (!response.state) {
            if (chState == 'true')
                $(elem).removeAttr('checked');
            else
                $(elem).attr('checked', 'checked');
        }
    }
    })
    return false;
}

function changeShownBackcallsType(type)
{
    $.ajax({
    type: "GET",
    url: "/admin_panel/backcalls",
    data:({'backcalls_type' : type}),
    success: function(response) {
        jQuery('#tablecontent').html(response.table);
        jQuery('.pagination').html(response.paginate);
    }
    })
    return false;
}