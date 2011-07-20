photo_index = 0
@addFileField = ->
  photo_index+=1
  $("<br/>").appendTo ".photo_fields"
  $($(".photo_fields > input:first").clone().attr("name", "photos[" + photo_index + "][photo]").val("")).appendTo ".photo_fields"
true

@deletePhoto = (path) ->
  $.ajax
    type: "POST"
    url: path
    success: (response) ->
      $("#images-list").html response
