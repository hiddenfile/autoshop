photo_index = 0
@addFileField = ->
  photo_index+=1
  $("<br/>").appendTo ".photo_fields"
  $($(".photo_fields > input:first").clone().attr("name", "photos[" + photo_index + "][photo]").val("")).appendTo ".photo_fields"
true

@deletePhoto = (elem, path, auth) ->
  $.ajax
    type: "DELETE"
    url: path
    data: ({'authenticity_token': auth})
    success: (response) ->
      if (response.state == true)
        elem.parent("p:first").remove();
