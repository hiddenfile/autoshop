// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function addToCart(auth,id, title, price) {
    console.log([id, title, price]);
    $.ajax({
        type: "PUT",
        url: "/shop_carts/add",
        data: ({'authenticity_token': auth,'id':id, 'title':title, 'price':price}),
        success: function(response) {
            console.log(response);
        }
    });
}