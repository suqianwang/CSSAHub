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
  this.originPlaceId = null;
  this.destinationPlaceId = null;

  var originInput = document.getElementById('ride_departure');
  var destinationInput = document.getElementById('ride_destination');

  var originAutocomplete = new google.maps.places.Autocomplete(originInput);
  // Specify just the place data fields that you need.
  originAutocomplete.setFields(['place_id', 'geometry', 'name']);

  var destinationAutocomplete =
      new google.maps.places.Autocomplete(destinationInput);
  // Specify just the place data fields that you need.
  destinationAutocomplete.setFields(['place_id', 'geometry', 'name']);

  this.setupPlaceChangedListener(originAutocomplete, 'ORIG', map);
  this.setupPlaceChangedListener(destinationAutocomplete, 'DEST', map);

  this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(originInput);
  this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(
      destinationInput);
      
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

AutocompleteDirectionsHandler.prototype.setupPlaceChangedListener = function(
    autocomplete, mode, map) {
  var me = this;
  autocomplete.bindTo('bounds', map);

  var originMarker;
  var destMarker;
  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();

    if (!place.place_id) {
      window.alert('Please select an option from the dropdown list.');
      return;
    }
    
    if (mode === 'ORIG') {
      me.originPlaceId = place.place_id;
      
      if (typeof originMarker != "undefined") {
        originMarker.setMap(null);
      }
      if (place.geometry) {
        originMarker = new google.maps.Marker({
          map: map,
          title: place.name,
          position: place.geometry.location
        });
        
        // var bounds = map.getBounds();
        // if(place.geometry.viewport) {
        //   bounds.union(place.geometry.viewport)
        // } else {
        //   bounds.extend(place.geometry.location)
        // }
        // map.fitBounds(bounds);
      }
    } else {
      me.destinationPlaceId = place.place_id;
      
      if (typeof destMarker != "undefined") {
        destMarker.setMap(null);
      }
      if (place.geometry) {
        destMarker = new google.maps.Marker({
          map: map,
          title: place.name,
          position: place.geometry.location
        });
        
        // var bounds = map.getBounds();
        // if(place.geometry.viewport) {
        //   bounds.union(place.geometry.viewport)
        // } else {
        //   bounds.extend(place.geometry.location)
        // }
        // map.fitBounds(bounds);
      }
    }
  });
};