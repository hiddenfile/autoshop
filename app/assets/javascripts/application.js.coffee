@showCategory = (id,current) ->
  $(".category").hide()
  $(".category" + id).show()
  $(".leftmenu div").css("color",'#a9aaaa')
  current.css("color",'#b0d323')