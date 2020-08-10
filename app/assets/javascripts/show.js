function initMap() {

  let latitude = Number(gon.latitude)
  let longitude = Number(gon.longitude)
  let station = gon.station
  let walk = gon.walk

  console.log('現在地から',walk,'分')

  let time = station + 'から' + walk + '分'

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

