function initMap() {

  navigator.geolocation.getCurrentPosition(
    function(position) {
      let data = position.coords;

      let lat = data.latitude;
      let lng = data.longitude;
      let latlng = new google.maps.LatLng(lat, lng);

      let infowindow = new google.maps.InfoWindow({
        content: "現在地"
      });

      present = new google.maps.Marker({
        map: map,
        position: latlng,
        icon : "https://maps.google.com/mapfiles/ms/icons/blue-dot.png"
      });

      present.addListener('click', function() {
        infowindow.open(map, present);
      });

    }
  )

  let latitude = Number(gon.latitude)
  let longitude = Number(gon.longitude)
  let station = gon.station
  let walk = gon.walk
  let station_exit = gon.station_exit

  console.log('現在地から',walk,'分')

  let time = station + station_exit + 'から' + walk + '分'

  console.log(time)

  let test ={lat: latitude, lng: longitude};
  let map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15,
      center: test
  });
  let transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);

  let infowindow = new google.maps.InfoWindow({
      content: time
  });

  let marker = new google.maps.Marker({
      position:test,
      map: map
  });

  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });
}

