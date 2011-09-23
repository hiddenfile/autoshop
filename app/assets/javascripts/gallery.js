$(window).bind("load", function() {
	$("div#my-folio-of-works").slideViewerPro({
		thumbs: 6,
		autoslide: true,
		asTimer: 3500,
		typo: true,
		galBorderWidth: 0,
		thumbsBorderOpacity: 0,
		buttonsTextColor: "#707070",
		buttonsWidth: 40,
		thumbsActiveBorderOpacity: 0.8,
		thumbsActiveBorderColor: "aqua",
		shuffle: true
		});
	$("div#basic").slideViewerPro();
	$("div#fewoptions").slideViewerPro({
		thumbs: 3,
		thumbsPercentReduction: 20,
		galBorderWidth: 0,
		galBorderColor: "aqua",
		thumbsTopMargin: 10,
		thumbsRightMargin: 10,
		thumbsBorderWidth: 5,
		thumbsActiveBorderColor: "gold",
		thumbsActiveBorderOpacity: 0.8,
		thumbsBorderOpacity: 0,
		buttonsTextColor: "#707070",
		leftButtonInner: "<img src='http://www.gcmingati.net/wordpress/wp-content/uploads/larw.gif' />",
		rightButtonInner: "<img src='http://www.gcmingati.net/wordpress/wp-content/uploads/rarw.gif' />",
		autoslide: true,
		typo: true
		});
	$("div#noui").slideViewerPro({
		galBorderWidth: 0,
		autoslide: true,
		thumbsVis: false,
		shuffle: true
		});
	$("div#flickit").slideViewerPro({
		autoslide: true,
		shuffle: true,
		asTimer: 3500,
		thumbsActiveBorderColor: "silver",
		buttonsTextColor: "silver",
		typo: true,
		galBorderWidth: 0,
		thumbsBorderOpacity: 0
		});
		});

$(function(){
	/**
	I've seen many slideViewerPro users adding these lines too.
	They're only needed to highlight the syntax within this page,
	it's NOT part of the slideViewerPro plugin!
	*/
	$.syntax({root: 'http://www.gcmingati.net/wordpress/wp-content/themes/giancarlo-mingati/js/jquery-syntax/'});
});