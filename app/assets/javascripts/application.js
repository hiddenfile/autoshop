// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var photo_index = 0
function addFileField()
{   photo_index++;
    $("<br/>").appendTo(".photo_fields");
    $($(".photo_fields > input:first").clone().attr("name","photos["+photo_index+"][photo]").val("")).appendTo(".photo_fields");
    return true;
}

function deletePhoto(path)
{
    $.ajax({
        type: 'POST',
        url: path,
        success: function(response){
            $("#images-list").html(response);
        }
    })
}