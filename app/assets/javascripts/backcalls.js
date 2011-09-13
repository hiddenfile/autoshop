$(document).ready(function() {
  $('#backcall_form').submit(function() {

        $.ajax({
            type:"POST",
            url: "/backcalls",
            data: ({'captcha' : jQuery('#backcall_captcha').attr('value'), 'text': jQuery('#backcall_message').attr('value'), 'product_id' : jQuery('#backcall_product').attr('value')}),
            success: function (response) {
                if (response.backcall)
                {
                   jQuery('.backcalls').append(response.backcall);
                   jQuery('#backcall_message').attr('value','');
                   jQuery('.errors').html('');
                }

                if (response.errors)
                {
                   jQuery('.errors').html(response.errors);
                }

                jQuery("#captcha_fields").html(response.captcha);
            }
        });
        return false;
  });
});