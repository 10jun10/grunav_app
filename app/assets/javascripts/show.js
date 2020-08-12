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

    },
    function(error) {
      let errorMessage = [
        "原因不明のエラーが発生しました。",
        "位置情報の取得が許可されませんでした。",
        "デバイスの位置が判定できませんでした。",
        "タイムアウトして位置情報を取得できませんでした。"
       ] ;

      alert( errorMessage[error.code] );
    },

    {
      enableHighAccuracy: false,
      timeout: 20000,
      maximumAge: 2000
    }
  );

  let latitude = Number(gon.latitude)
  let longitude = Number(gon.longitude)
  let name = gon.res_name

  let test ={lat: latitude, lng: longitude};
  let map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15,
      center: test
  });
  let transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);

  let infowindow = new google.maps.InfoWindow({
      content: name
  });

  let marker = new google.maps.Marker({
      position:test,
      map: map
  });

  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });
}

