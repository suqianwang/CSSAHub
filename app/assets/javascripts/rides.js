function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    mapTypeControl: false,
    center: {lat: 30.617, lng: -96.339},
    zoom: 13
  });
  
  new AutocompleteDirectionsHandler(map);
}

function AutocompleteDirectionsHandler(map) {
  this.map = map;

  var originInput = document.getElementById('ride_departure');
  var destinationInput = document.getElementById('ride_destination');

  var originAutocomplete = new google.maps.places.Autocomplete(originInput);
  // Specify just the place data fields that you need.
  originAutocomplete.setFields(['place_id', 'geometry', 'name']);

  var destinationAutocomplete =
      new google.maps.places.Autocomplete(destinationInput);
  // Specify just the place data fields that you need.
  destinationAutocomplete.setFields(['place_id', 'geometry', 'name']);

  var placesService = new google.maps.places.PlacesService(map);
  var originMarker;
  var destMarker;
  
  this.setupPlaceChangedListener(originInput, originAutocomplete, map, originMarker);
  this.setupPlaceChangedListener(destinationInput, destinationAutocomplete, map, destMarker);

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
  
  initMarker(originInput.value, map, placesService);
  initMarker(destinationInput.value, map, placesService);
}

AutocompleteDirectionsHandler.prototype.setupPlaceChangedListener = function(input, autocomplete, map, marker) {
  autocomplete.bindTo('bounds', map);
  
  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();

    if (!place.place_id) {
      input.value = null;
      window.alert('Please select an option from the dropdown list.');
      return;
    }
    
    if (typeof marker != "undefined") {
      marker.setMap(null);
    }
    if (place.geometry) {
      marker = placeMarker(place.geometry.location, map)
      
      // var bounds = map.getBounds();
      // if(place.geometry.viewport) {
      //   bounds.union(place.geometry.viewport)
      // } else {
      //   bounds.extend(place.geometry.location)
      // }
      // map.fitBounds(bounds);
    }
  });
};

function initMarker(query, map, placesService) {
  var request = { query: query, fields: ['geometry'] };
  placesService.findPlaceFromQuery(request, function(results, status) {
    if (status === google.maps.places.PlacesServiceStatus.OK) {
      placeMarker(results[0].geometry.location, map);
    }
  });
}

function placeMarker(latLng, map) {
  var marker = new google.maps.Marker({
    position: latLng,
    map: map
  });
  return marker;
}