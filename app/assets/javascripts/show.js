function initMap() {

  let latitude = Number(gon.latitude)
  let longitude = Number(gon.longitude)
  let address = gon.address

  let test ={lat: latitude, lng: longitude};
  let map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15,
      center: test
  });
  let transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);

  let marker = new google.maps.Marker({
      position:test,
      map: map
  });
}