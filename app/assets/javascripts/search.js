if (navigator.geolocation) {
  navigator.geolocation.getCurrentPosition(
    function(position) {

      let lat = position.coords.latitude;
      let lng = position.coords.longitude;

      // 位置情報取得タイミング
      // alert("現在位置、\n[" + lat + "," + lng + "]\n");

      $(".search").append(
        `<input type="hidden" id="id" name="lat" value="${lat}">
        <input type="hidden" id="id" name="lng" value="${lng}">`
      );

      $(".select").change(function() {
        let num = $(this).val();
        let radius = 500;
        if (num == "1") {
          radius = 300;
        } else if (num == "2") {
          radius = 500;
        } else if (num == "3") {
          radius = 1000;
        }
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
} else {
let errorMessage = "お使いの端末は、GeoLacation APIに対応していません。";
alert(errorMessage);
}