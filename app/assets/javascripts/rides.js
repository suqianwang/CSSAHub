function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    mapTypeControl: false,
    center: {lat: 30.617, lng: -96.339},
    zoom: 13
  });
  
  new AutocompleteDirectionsHandler(map);
}

var originMarker;
var destMarker;
function AutocompleteDirectionsHandler(map) {
  this.map = map;

  var originInput = document.getElementById('ride_departure');
  var destinationInput = document.getElementById('ride_destination');

  var originAutocomplete = new google.maps.places.Autocomplete(originInput);
  // Specify just the place data fields that you need.
  originAutocomplete.setFields(['place_id', 'geometry', 'name']);

  var destinationAutocomplete = new google.maps.places.Autocomplete(destinationInput);
  // Specify just the place data fields that you need.
  destinationAutocomplete.setFields(['place_id', 'geometry', 'name']);
  
  var placesService = new google.maps.places.PlacesService(map);
  if (originInput.value != "") {
    initMarker("ORIG", originInput.value, map, placesService);
  }
  if (destinationInput.value != "") {
    initMarker("DEST", destinationInput.value, map, placesService);
  }
  
  this.setupPlaceChangedListener("ORIG", originInput, originAutocomplete, map);
  this.setupPlaceChangedListener("DEST", destinationInput, destinationAutocomplete, map);

  this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(originInput);
  this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(destinationInput);
      
  google.maps.event.addDomListener(originInput, 'blur', function() {
    if ($('.pac-item:hover').length === 0) {
      google.maps.event.trigger(this, 'focus', {});
      google.maps.event.trigger(this, 'keydown', {
        keyCode: 13
      });
    }
  });
  
  google.maps.event.addDomListener(destinationInput, 'blur', function() {
    if ($('.pac-item:hover').length === 0) {
      google.maps.event.trigger(this, 'focus', {});
      google.maps.event.trigger(this, 'keydown', {
        keyCode: 13
      });
    }
  });
}

AutocompleteDirectionsHandler.prototype.setupPlaceChangedListener = function(mode, input, autocomplete, map) {
  autocomplete.bindTo('bounds', map);
  
  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();

    if (!place.place_id) {
      input.value = null;
      window.alert('Please select an option from the dropdown list.');
      return;
    }
    
    if (place.geometry) {
      placeMarker(mode, place.geometry.location, map)
    }
  });
};

function initMarker(mode, query, map, placesService) {
  var request = { query: query, fields: ['geometry'] };
  placesService.findPlaceFromQuery(request, function(results, status) {
    if (status === google.maps.places.PlacesServiceStatus.OK) {
      placeMarker(mode, results[0].geometry.location, map);
    }
  });
}

function placeMarker(mode, latLng, map) {
  var bounds = new google.maps.LatLngBounds();
  if (mode == "ORIG") {
    if (typeof originMarker != "undefined") {
      originMarker.setMap(null);
    }
    originMarker = new google.maps.Marker({
      position: latLng,
      map: map
    });
    
    if(typeof destMarker != "undefined") {
      bounds.extend(destMarker.getPosition());
    }
  }
  else {
    if (typeof destMarker != "undefined") {
      destMarker.setMap(null);
    }
    destMarker = new google.maps.Marker({
      position: latLng,
      map: map
    });
    
    if(typeof originMarker != "undefined") {
      bounds.extend(originMarker.getPosition());
    }
  }
  
  bounds.extend(latLng);
  map.fitBounds(bounds);
  map.panToBounds(bounds);
}