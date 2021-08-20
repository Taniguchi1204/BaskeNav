let map
let geocoder
let marker = []; // マーカーを複数表示させたいので、配列化
let infoWindow = []; // 吹き出しを複数表示させたいので、配列化

function initMap(){ // APIキーと一緒にURLに記載
  geocoder = new google.maps.Geocoder() //GoogleMapsAPIジオコーディングサービスにアクセス
  if(document.getElementById('map')){ //'map'というidを取得できたら実行
    map = new google.maps.Map(document.getElementById('map'), { //'map'というidを取得してマップを表示
      center: {lat: 35.6809591, lng: 139.7673068}, //最初に表示する場所（東京駅）
      zoom: 12, //拡大率（1〜21まで設定可能）
    });
  }else if(document.getElementById('show_map')){
    map = new google.maps.Map(document.getElementById('show_map'), { //'show_map'というidを取得してマップを表示
      center: {lat: gon.lat, lng: gon.lng}, //controllerで定義した変数を緯度・経度の値
      zoom: 12, //拡大率（1〜21まで設定可能）
    });

    marker = new google.maps.Marker({ //GoogleMapにマーカーを落とす
      position:  {lat: gon.lat, lng: gon.lng}, //マーカーを落とす位置を決める（値はDBに入っている）
      map: map //マーカーを落とすマップを指定
    });
  }else{

    map = new google.maps.Map(document.getElementById('index_map'), { //'map'というidを取得してマップを表示
      center: {lat: 35.6809591, lng: 139.7673068}, //最初に表示する場所（東京駅）
      zoom: 12, //拡大率（1〜21まで設定可能）
    });

    $.ajax({
      url: "/facilities",
      dataType : 'json',
    }).done(function (markerData){

        // 繰り返し処理でマーカーと吹き出しを複数表示させる
      for (var i = 0; i < markerData.length; i++) {
        let id           = markerData[i]['id']
        let name         = markerData[i]['name']
        let opening      = markerData[i]['opening']
        let closing      = markerData[i]['closing']
        let phone_number = markerData[i]['phone_number']

        // 各地点の緯度経度を算出
        markerLatLng = new google.maps.LatLng({
          lat: markerData[i]['lat'],
          lng: markerData[i]['lng']
        });

        // 各地点のマーカーを作成
        marker[i] = new google.maps.Marker({
          position: markerLatLng,
          map: map
        });

        // 各地点の吹き出しを作成
        infoWindow[i] = new google.maps.InfoWindow({
          // 吹き出しの内容
          content: `<p>店名：${name}</p>
                    <p>営業時間：${opening}~${closing}</p>
                    <p>電話番号：${phone_number}</p>
                    <a href='/facilities/${ id }'>詳細画面</a>`
        });

        // マーカーにクリックイベントを追加
        markerEvent(i);
      }
    })
  }

  // マーカーをクリックしたら吹き出しを表示
  function markerEvent(i) {
    marker[i].addListener('click', function () {
      infoWindow[i].open(map, marker[i]);
    });
  }
}




function codeAddress(){ //コールバック関数
  let inputAddress = document.getElementById('address').value; //'address'というidの値（value）を取得

  geocoder.geocode( { 'address': inputAddress}, function(results, status) { //ジオコードしたい住所を引数として渡す
    if (status == 'OK') {
      let lat = results[0].geometry.location.lat(); //ジオコードした結果の緯度
      let lng = results[0].geometry.location.lng(); //ジオコードした結果の経度
      let mark = {
          lat: lat, //緯度
          lng: lng  //経度
      };
      map.setCenter(results[0].geometry.location); //最も近い、判読可能な住所を取得したい場所の緯度・経度
      let marker = new google.maps.Marker({
          map: map, //マーカーを落とすマップを指定
          position: results[0].geometry.location //マーカーを落とす位置を決める
      });
    } else {
      alert('該当する結果がありませんでした');
    }
  });
}

function AddressSearch(address){ //コールバック関数

  geocoder.geocode( { 'address': address}, function(results, status) { //ジオコードしたい住所を引数として渡す
    if (status == 'OK') {
      let lat = results[0].geometry.location.lat(); //ジオコードした結果の緯度
      let lng = results[0].geometry.location.lng(); //ジオコードした結果の経度

      map.setCenter(results[0].geometry.location); //最も近い、判読可能な住所を取得したい場所の緯度・経度

      map = new google.maps.Map(document.getElementById('index_map'), { //'map'というidを取得してマップを表示
        center: {lat: lat, lng: lng}, //最初に表示する場所（東京駅）
        zoom: 10, //拡大率（1〜21まで設定可能）
      });

    } else {
      alert('該当する結果がありませんでした');
    }
  });
}