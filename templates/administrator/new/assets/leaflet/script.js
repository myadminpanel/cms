$(document).ready(function(){

	/*[---------- LEAFLET Map   ----------]*/


	function leafletMap (id) {
		if($("#"+ id).length > 0 ) {
			let lat = parseFloat($("#" + id).attr("data-lat"));
			let lng = parseFloat($("#" + id).attr("data-lng"));

			var map = L.map(id, {
				center  : [lat,lng],
				center: [lat, lng],
				zoom: 15,
			})
			var myIcon = L.icon({
				iconUrl: '/templates/administrator/new/assets/leaflet/images/map-marker-icon.png',
				iconSize: [64, 64],
				iconAnchor: [32, 64]
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

			map.on('click', function(e) {
				var requestform = e.latlng;
				marker.setLatLng(requestform); 
				document.getElementById('latitude').value = marker.getLatLng().lat;
				document.getElementById('longitude').value = marker.getLatLng().lng;
			});

			$('#latitude').on('change', function(){
				let lat = document.getElementById('latitude').value;
				let lng = document.getElementById('longitude').value;
				//var newLatLng = ;
				marker.setLatLng(new L.LatLng(lat, lng)); 
				map.panTo(new L.LatLng(lat, lng));

			});
			
			setTimeout(function(){
				map.invalidateSize(true);
				map.locate({setView: true}, 14);
			}, 100)
		}
	}

	$('a[href="#map"]').on('click', function(){
		leafletMap("mapset");
	});

	


});

function initAutocomplete() {
	var map = new google.maps.Map(document.getElementById('map2'), {
	  center: {lat: 40.409264, lng: 49.867092},
	  zoom: 13,
	  mapTypeId: 'roadmap'
	});

	// Create the search box and link it to the UI element.
	var input = document.getElementById('pac-input');
	var searchBox = new google.maps.places.SearchBox(input);
	//map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

	// Bias the SearchBox results towards current map's viewport.
	map.addListener('bounds_changed', function() {
	  searchBox.setBounds(map.getBounds());
	});

	var markers = [];
	// Listen for the event fired when the user selects a prediction and retrieve
	// more details for that place.
	searchBox.addListener('places_changed', function() {
	  var places = searchBox.getPlaces();

	  if (places.length == 0) {
		return;
	  }

	  // Clear out the old markers.
	  markers.forEach(function(marker) {
		marker.setMap(null);
	  });
	  markers = [];

	  // For each place, get the icon, name and location.
	  var bounds = new google.maps.LatLngBounds();
	  places.forEach(function(place) {
		if (!place.geometry) {
		  console.log("Returned place contains no geometry");
		  return;
		}
		var icon = {
		  url: place.icon,
		  size: new google.maps.Size(71, 71),
		  origin: new google.maps.Point(0, 0),
		  anchor: new google.maps.Point(17, 34),
		  scaledSize: new google.maps.Size(25, 25)
		};

		// Create a marker for each place.
		markers.push(new google.maps.Marker({
		  map: map,
		  icon: icon,
		  title: place.name,
		  draggable: true,
		  position: place.geometry.location
		}));

		document.getElementById("latitude").value = place.geometry.location.lat();
		document.getElementById("longitude").value = place.geometry.location.lng(); 

		google.maps.event.addListener(markers[0], 'dragend', function (event) {
			document.getElementById("latitude").value = this.getPosition().lat();
			document.getElementById("longitude").value = this.getPosition().lng();
		});

		if (place.geometry.viewport) {
		  // Only geocodes have viewport.
		  bounds.union(place.geometry.viewport);
		} else {
		  bounds.extend(place.geometry.location);
		}
	  });
	  map.fitBounds(bounds);
	});
  }

