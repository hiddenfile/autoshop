photo_index = 0
@addFileField = ->
  photo_index+=1
  $("<br/>").appendTo ".photo_fields"
  $($(".photo_fields > input:first").clone().attr("name", "photos[" + photo_index + "][photo]").val("")).appendTo ".photo_fields"
true

@deletePhoto = (elem, path) ->
  $.ajax
    type: "POST"
    url: path
    data: ({'_method': 'DELETE', 'authenticity_token' : $("meta[name='csrf-token']").attr('content')})
    success: (response) ->
      if (response.state)
        elem.parent("p:first").remove();