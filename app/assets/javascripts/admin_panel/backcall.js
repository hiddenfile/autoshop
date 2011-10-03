function deleteBackcall(id,elem)
{
    $.ajax({
    type: "DELETE",
    url: "/admin_panel/backcalls/"+id,
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
    type: "PUT",
    url: "/admin_panel/backcalls/"+id,
    data: ({'backcall_attr' : { 'checked' : chState}}),
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