$( document ).on('ready', function() {
  if($('section.contact-section').length) {
    map = new google.maps.Map(document.getElementById('contact-map'), {
      center: { lat: -34.920057, lng: -56.153547 },
      zoom: 15
    });

    var locations = [
      ['Casa Central', -34.920057, -56.153547]
    ];

    for (var i = 0; i < locations.length; i++) {
      var location = locations[i];
      var marker = new google.maps.Marker({
        position: {lat: location[1], lng: location[2]},
        map: map,
        title: location[0],
        zIndex: i,
      });
    }
  };
});
