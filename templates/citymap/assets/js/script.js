/*
=====================================================
					=    main scripts starts   =
=====================================================
*/
$(document).ready(function(){

	



	/*[---------- Waves Effect some button && link   ----------]*/
	$("ul.menus li a,  .slider-buttons button, .more a").addClass("waves-effect");

	/*[---------- Owl Carousel   ----------]*/
	$(".last-added-ul.owl-carousel").owlCarousel({
		loop:false,
		margin:10,
		nav:true,
		items:5,
		autoplay:true,
		autoplayTimeout:3000,
		autoplayHoverPause:true,
		responsive:{
			0: {
				items: 2
			},
			375:{
				items:2
			},
			600:{
				items:3
			},
			1000: {
				items : 4 
			},
			1200: {
				items : 7 
			}
		}
	});

	$(".company-ul.owl-carousel").owlCarousel({
		loop:true,
		margin:10,
		nav:true,
		items:5,
		autoplay:true,
		autoplayTimeout:3000,
		autoplayHoverPause:true,
		responsive:{
			0: {
				items: 2
			},
			375:{
				items:2
			},
			600:{
				items:3
			},
			1000: {
				items : 4 
			},
			1200: {
				items : 5
			}
		}
	});

	$(".c-profile-slider-ul.owl-carousel").owlCarousel({
		loop:false,
		margin:10,
		nav:true,
		items:5,
		autoplay:true,
		autoplayTimeout:3000,
		autoplayHoverPause:true,
		responsive:{
			0: {
				items: 4
			},
			375:{
				items:4
			},
			600:{
				items:6
			},
			1000: {
				items : 4 
			},
			1200: {
				items : 4
			}
		}
	});

	$(".c-profile-slider-ul.owl-carousel").on('translated.owl.carousel', function(event) {
		var imageSrc = $('.owl-carousel').find('.owl-item.active img').attr('src');
		$(".c-profile-active-slide img").attr("src", imageSrc);
		$(".c-profile-active-slide a").attr("href", imageSrc );
	})
	
	$("[jsClick='nextSlide']").on("click", function(){
		$("[jsGet='carousel']").trigger("next.owl.carousel");
	});
	$("[jsClick='prevSlide']").on("click", function(){
		$("[jsGet='carousel']").trigger("prev.owl.carousel");
	});

	/*[---------- QR CODE   ----------]*/
	$('#qr-code').qrcode({
		text: $("#qr-code").attr("data-url"),
		width: $("#qr-code").width(),
		height:$("#qr-code").height()
	});

	/*[---------- turn on & off preventDefault()   ----------]*/
	$("[data-prevent='off']").on("click", function(e){
		e.preventDefault();
	});

	 /*[----------Youtube Video Iframe    ----------]*/
	let videoSource = $("#videoFrame").attr("src");
	$("[data-video-url]").on("click", function(){
		let dataUrl = $(this).attr("data-video-url");
		$("#videoFrame").attr("src", videoSource +'/'+  dataUrl);
	});
	$("[data-video-frame='close']").on("click", function(){
		$("#videoFrame").attr("src", "");
	});
	$("body").on("click", function(){
		setTimeout(function(){
		   if(!$(".modal.fade").hasClass("show")) {
			$("#videoFrame").attr("src", "");
		   }
		}, 500)
	})
	
	 /*[---------- MENU    ----------]*/
	$(".menus").on("mouseover", function(){
		$("body").addClass("overflow")
	});
	$(".menus").on("mouseout", function(){
		$("body").removeClass("overflow")
	});

	/*[----------  PAGE UP ANIMATION  ----------]*/
	$(".page-up").on("click", function(){
		$("html, body").animate({
			scrollTop:0
		}, 500)
	});

	/*[----------  BLOG FILTER ----------]*/
	$("[data-blog-filter='large']").on("click", function(){
		let t = $(this);
		t.parent().find("button").removeClass("active");
		t.addClass("active");
		$(".blog-block > div").addClass("col-md-12 col-sm-12 col-12");
		$(".blog-block > div").removeClass("col-md-4 col-sm-6 col-12");
		$(".blog-block > div").attr("data-filter", "large");
	});
	$("[data-blog-filter='list']").on("click", function(){
		let t = $(this);
		t.parent().find("button").removeClass("active");
		t.addClass("active");
		$(".blog-block > div").addClass("col-md-4 col-sm-6 col-12");
		$(".blog-block > div").removeClass("col-md-12 col-sm-12 col-12");
		$(".blog-block > div").attr("data-filter", "list");
	});

	/*[----------  SERVICE FILTER ----------]*/
	$("[data-service-filter='large']").on("click", function(){
		let t = $(this);
		t.parent().find("button").removeClass("active");
		t.addClass("active");
		$(".company-block.service > ul > li").attr("data-filter", "large");
		$(".company-block.service > ul > li > div.company-content > span.content").show();
	});
	$("[data-service-filter='list']").on("click", function(){
		let t = $(this);
		t.parent().find("button").removeClass("active");
		t.addClass("active");
		$(".company-block.service > ul > li").attr("data-filter", "list");
		$(".company-block.service > ul > li > div.company-content > span.content").hide();
	});
	 
	/*[----------  PRODUCT FILTER ----------]*/
	$("[data-product-filter='large']").on("click", function(){
		let t = $(this);
		t.parent().find("button").removeClass("active");
		t.addClass("active");
		$(".company-block.product > ul > li").attr("data-filter", "large");
		$(".company-block.service > ul > li > div.company-content > span.content").show();
	});
	$("[data-product-filter='list']").on("click", function(){
		let t = $(this);
		t.parent().find("button").removeClass("active");
		t.addClass("active");
		$(".company-block.product > ul > li").attr("data-filter", "list");
		$(".company-block.service > ul > li > div.company-content > span.content").hide();
	});

	 /*[---------- Google Map CATEGORY MENU  ----------]*/
	// $(".search-menu li").on("click", function(e){
	// 	var t = $(this);
	// 	t.siblings("li").removeClass("active");
	// 	t.addClass("active");
	// });

	/*[---------- Google Map AUTOCOMPLETE  ----------]*/
	$("[jsKeyup='search']").on("keyup", function(){
		var t = $(this);
		var value = t.val().toLowerCase();
		$("[jsGet='search'] > li").filter(function() {
			var f = $(this);
			f.toggle(f.text().toLowerCase().indexOf(value) > -1);
		});
	});

	$("[jsKeyup='search']").on("focus", function(){
		$("[jsGet='search']").fadeIn();
	})
	$("[jsKeyup='search']").on("blur", function(){
		$("[jsGet='search']").fadeOut();
	})

	$("[jsGet='search'] > li ").on("click", function(){
		var t = $(this);
	   var keyword =  t.attr("data-text");
	   $("[jsKeyup='search']").val(keyword);
	});

	$(".category-block-ul li.header, .aside-block-ul > li.header, [aria-closed='false']").on("click", function(){
		$(this).toggleClass("open");
	});

	/*[---------- MOBILE MENU BUTTON  ----------]*/
	$("button[jsclick='mob-menu-button']").on("click", function(){
		$(this).toggleClass("open");
		$(".menus").toggleClass("open");
		if($(this).hasClass("open")) {
			$("body").addClass("overflow")
		}else {
			$("body").removeClass("overflow")
		}
	});

	  /*[---------- CONTACT FORM  ----------]*/
	  $("[jsFocus='show-form']").on("focus", function(){
		  $("[jsFocus='hide-form']").addClass("show");
	  });

	  $('.contact-form').on('click', function(){
		$("[jsFocus='hide-form']").addClass("show");
	  });

	  $(document).on("click", function(e){
		   if(!$(e.target).hasClass("contact-form") && !$(e.target).parents().hasClass("contact-form") ) {
			$("[jsFocus='hide-form']").removeClass("show");
		   }
	  });

	  $(".page-tabs.nav.nav-tabs li a").on("click", function(){
	  		setTimeout(function(){
			  	var limitCounter = [];
			  	var limitCounter2 = [];
			  	$(".c-profile-tab-content > .tab-pane.active ul li").each(function(){
			  		 var limitHeight = $(this).find(".company-content").height();
			  		 limitCounter.push(limitHeight);
			  	});
			  	let maxPx1 = Math.max(...limitCounter);
			  	$(".c-profile-tab-content > .tab-pane.active ul li").find(".company-content").height(maxPx1);
			  	$(".c-profile-tab-content > .tab-pane.active .col-md-4").each(function(){
			  		 var limitHeight = $(this).find(".blog-content").height();
			  		 limitCounter2.push(limitHeight);
			  	});
		  		 let maxPx2 = Math.max(...limitCounter2);
		  		 $(".c-profile-tab-content > .tab-pane.active .col-md-4").find(".blog-content").height(maxPx2);
			}, 250)
	  });

	  $(".user-profile-menu li:nth-child(3) a").one("click", function(){
	  	 	 leafletMap1("mapset");
	  });

	  $("input[type='checkbox']").parent().addClass("checkbox-style");
	  $("input[type='checkbox']").on("change", function(){
	  		var t = $(this);
	  	if(t.prop("checked")) {
	  		t.parent().addClass("selected");
	  	}else {
	  		t.parent().removeClass("selected");
	  	}
	  });


	   /*[---------- SUBSCRIBE EMAIL  ----------]*/


	   $("[jsClick='subscribe']").on("click", function(e){
		e.preventDefault();
		let validEmail = /^([a-z\d\.\-]+)\@([a-z\d]+)\.([a-z]{2,8})(\.[a-z]{2,8})?$/;
		let emailVal = $("#subscribe-email").val();
		
		if(validEmail.test(emailVal)) {
			let form = $(this).parents("[jsAnimate='shake']");
			form.addClass("loading");
			let findText = form.prev("[jsGet='art-title']").text();
			setTimeout(function(){
				form.html("<h3 jsGet='art-title'>"+findText+"</h3>");
				form.removeClass("loading");
				console.log(findText);
				$("span[jsGet='art-title']").remove();
			}, 1000)

			//YOUR AJAX HERE
			   
		}else {
		   $("[jsAnimate='shake']").addClass("shake-in");
		   setTimeout(function(){
				$("[jsAnimate='shake']").removeClass("shake-in");
		   }, 200)
		}
	});

	  /*[---------- InDICATOR   ----------]*/
	  $(document).on("scroll", function(){
	  	let topWindow =  document.querySelector("[jsGet='header']").offsetHeight * 2;
		let scrolled = document.documentElement.scrollTop;
		if(scrolled >= topWindow ) {
			document.querySelector("[jsGet='header']").classList.add("fixed-anime");
		}else {
			document.querySelector("[jsGet='header']").classList.remove("fixed-anime");
		};
	  });

	  /*[---------- tooltip   ----------]*/
	   $('[data-toggle="tooltip"]').tooltip();   
	 	
});
/*[---------- LEAFLET Map   ----------]*/
	function leafletMap (id) {
		if($("#"+ id).length > 0 ) {
			let lat = parseFloat($("#" + id).attr("data-lat"));
			let lng = parseFloat($("#" + id).attr("data-lng"));
			let msg = parseFloat($("#" + id).attr("data-msg"));
			let detect = $("#" + id).attr("data-detect");

			var map = L.map(id, {
				center  : [lat,lng],
				center: [lat, lng],
				zoom: 12,
				fullscreenControl: true
			})
			var myIcon = L.icon({
				iconUrl: '/templates/citymap/assets/css/icons/google/marker.png',
				iconSize: [65, 80],
				iconAnchor: [22, 94],
				popupAnchor: [-3, -76]
			});
			var marker = L.marker([lat,lng], {icon: myIcon}).addTo(map);
		
			var Esri_WorldGrayCanvas = L.tileLayer('https://map.citymap.az/osm_tiles/{z}/{x}/{y}.png', {
				attribution: 'CityMap',
				maxZoom: 18
			});
			map.addLayer(Esri_WorldGrayCanvas); 
			marker.addTo(map); // Adding marker to the map
			
			
			if(detect == 'true')
			{
				if (!navigator.geolocation)
				{
					return false;
				}
				else
				{
					navigator.geolocation.getCurrentPosition(function(position) {
						let lat = position.coords.latitude;
						let lng = position.coords.longitude;
						map.invalidateSize(true);
						map.locate({setView: true}, 12);
						marker.setLatLng(new L.LatLng(lat, lng)); 
						map.panTo(new L.LatLng(lat, lng));
					});
				}
				
			}
			

			map.scrollWheelZoom.disable();

			$("#"+id).bind('mousewheel DOMMouseScroll', function (event) {
			  event.stopPropagation();
			   if (event.ctrlKey == true) {
					   event.preventDefault();
				   map.scrollWheelZoom.enable();
					 $('#'+id).removeClass('map-scroll');
				   setTimeout(function(){
					   map.scrollWheelZoom.disable();
				   }, 1000);
			   } else {
				   map.scrollWheelZoom.disable();
				   $('#'+id).addClass('map-scroll');
			   }
		  
		   });
		  
			$(window).bind('mousewheel DOMMouseScroll', function (event) {
				 $('#'+id).removeClass('map-scroll');
			})
		}
	}

$(window).on("load", function(){

	setTimeout(function(){
		$("body").removeClass("active");
		leafletMap("map");
		$("img").attr("data-filter", "false");

		/*[---------- auto margin social   ----------]*/
	 	var mediaQuery = window.matchMedia("(max-width: 575px)");
	 	function onResize (query) {
	 		if(query.matches) {
	 			var dHeight = parseInt($(".c-profile-controls").height() + 20);
	 			$(".company-profile-block").css("margin-bottom", dHeight + 'px');
		 	}
	 	}
	 	onResize(mediaQuery);
	 	mediaQuery.addListener(onResize)
	}, 500);

	setTimeout(function(){
		/*[---------- Limit title  ----------]*/
		var limitCounter1 = [];
		$(".last-added-block .last-added-ul > li").each(function(){
			var limitHeight = $(this).find(".last-added-content").height();
			limitCounter1.push(limitHeight);
			let maxPx = Math.max(...limitCounter1);
			setTimeout(function(){
				 $(".last-added-block .last-added-ul > li").find(".last-added-content").height(maxPx);
			}, 100);
		});

	   	var limitCounter2 = [];
		$(".last-added-ul.owl-carousel .owl-item").each(function(){
			var limitHeight = $(this).find("li .last-added-content").height();
			limitCounter2.push(limitHeight);
			let maxPx = Math.max(...limitCounter2);
			 setTimeout(function(){
			 	$(".last-added-ul.owl-carousel .last-added-content").height(maxPx+10);
			 }, 100);
		});

		var limitCounter3 = [];
		$(".company-ul li").each(function(){
			var limitHeight = $(this).find(".company-content").height();
			limitCounter3.push(limitHeight);
			let maxPx = Math.max(...limitCounter3);
			 setTimeout(function(){
			 	 $(".company-ul li").find(".company-content").height(maxPx+10);
			 }, 100);
		   
		});

		var limitCounter4 = [];
		$(".company-block.product .company-ul > li").each(function(){
			var limitHeight = $(this).find(".last-added-content").height();
			limitCounter4.push(limitHeight);
			let maxPx = Math.max(...limitCounter4);
			setTimeout(function(){
				 $(".company-block.product .company-ul > li").find(".last-added-content").height(maxPx);
			}, 100);
		});

		var limitCounter5 = [];
		$(".mx-825 .last-added-ul > li").each(function(){
			var limitHeight = $(this).find(".last-added-content").height();
			limitCounter5.push(limitHeight);
			let maxPx = Math.max(...limitCounter5);
			setTimeout(function(){
				 $(".mx-825 .last-added-ul > li").find(".last-added-content").height(maxPx);
			}, 100);
		});

		var limitCounter6 = [];
		$(".blog-block:not('.tab-blog') .col-md-4").each(function(){
			var limitHeight = $(this).find(".blog-content").height();
			limitCounter6.push(limitHeight);
			let maxPx = Math.max(...limitCounter6);
			setTimeout(function(){
				 $(".blog-block .col-md-4").find(".blog-content").height(maxPx+20);
			}, 100);
		});
	}, 1000)
   $(".listed-style-block button.active").trigger("click");
});


function leafletMap1 (id) {
	if($("#"+ id).length > 0 ) {
		let lat = parseFloat($("#" + id).attr("data-lat"));
		let lng = parseFloat($("#" + id).attr("data-lng"));
		let detect = $("#" + id).attr("data-detect");
		console.log(detect);

		var map = L.map(id, {
			center  : [lat,lng],
			center: [lat, lng],
			zoom: 15,
			fullscreenControl: true
		})
		var myIcon = L.icon({
			iconUrl: '/templates/citymap/assets/css/icons/google/marker.png',
			iconSize: [65, 80],
			iconAnchor: [22, 94],
			popupAnchor: [-3, -76]
		});
		var marker = L.marker([lat,lng], {icon: myIcon, draggable: true}).addTo(map);
	
		var Esri_WorldGrayCanvas = L.tileLayer('https://map.citymap.az/osm_tiles/{z}/{x}/{y}.png', {
			attribution: 'CityMap',
			maxZoom: 18
		});
		map.addLayer(Esri_WorldGrayCanvas); 

		marker.addTo(map); // Adding marker to the map

		marker.on('dragend', function (e) {
			document.getElementById('latitude').value = marker.getLatLng().lat;
			document.getElementById('longitude').value = marker.getLatLng().lng;
		});

		
		
		
	}
}