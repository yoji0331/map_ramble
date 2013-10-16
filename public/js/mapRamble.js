/*global google, $, console, alert, MAPRAMBLE */
/*jslint browser:true */

(function () {
    'use strict';

    // 使用する変数の準備
    MAPRAMBLE.markers = [];
    MAPRAMBLE.current = {};

    // デバッグ情報の表示
    MAPRAMBLE.debug = false;
    MAPRAMBLE.console = {};
    MAPRAMBLE.console.log = function (message) {
        if (MAPRAMBLE.debug === true) {
            console.log(message);
        }
    };

    // クエリー文字列を取り出すjQuery拡張
    $.extend({
        getUrlVars: function() {
            var vars = [], hash, hashes, i;
            hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (i = 0; i < hashes.length; i += 1) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        },
        getUrlVar: function(name) {
            return $.getUrlVars()[name];
        }
    });

    // 取得したJSONを配列に変換する
    MAPRAMBLE.jsonConvertArray = function (data) {
        var i, id, array = [];
        if (data) {
            for (i = 0; i < data.length; i += 1) {
                id = data[i].id;
                array[id] = data[i];
            }
        }
        return array;
    };

    // 初期値の設定
    MAPRAMBLE.setInitial = function () {
/*
        var id, places, queries, initial, location;

        places = MAPRAMBLE.places;
        location = MAPRAMBLE.location;
        initial = MAPRAMBLE.initial;

        // クエリー文字列の取得
        queries = $.getUrlVars();

        // places_idまたはlat、lngが含まれている場合、初期値を上書き
        if (queries.hasOwnProperty('places_id')) {
            id = queries.places_id;
            if (places.hasOwnProperty(id)) {
                places[id].isCurrent = true;
                initial.lat = places[id].lat;
                initial.lng = places[id].lng;
                initial.zoom = 15;
            }
        } else if (queries.hasOwnProperty('locations_id')) {
            initial.lat = location.lat;
            initial.lng = location.lng;
            initial.zoom = 15;
        }
*/
        MAPRAMBLE.console.log(MAPRAMBLE.initial);
    };

    // マップを生成
    MAPRAMBLE.createMap = function () {
        var initial, options;
        initial = MAPRAMBLE.initial;

        options = {
            zoom: initial.zoom,
            center: new google.maps.LatLng(initial.lat, initial.lng),
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        MAPRAMBLE.console.log(initial);
        MAPRAMBLE.console.log(options);
        // マップの生成
        MAPRAMBLE.map = new google.maps.Map(document.getElementById("mapCanvas"), options);
    };

    // マーカー群を追加
    MAPRAMBLE.addPlaceMarkers = function () {
        MAPRAMBLE.places.map(function (place) {
            MAPRAMBLE.addMarker(place);
        });
    };

    // 位置マーカーを削除
    MAPRAMBLE.deleteLocationMarker = function () {
        if (MAPRAMBLE.hasOwnProperty('locationMarker')) {
            MAPRAMBLE.locationMarker.setMap(null);
        }
        if (MAPRAMBLE.hasOwnProperty('circle')) {
            MAPRAMBLE.circle.setMap(null);
        }
    };

    // 個々のマーカーを追加
    MAPRAMBLE.addMarker = function (place) {
        var marker, options;

        options = {
            position: new google.maps.LatLng(place.lat, place.lng),
            map: MAPRAMBLE.map
        };

        if (place.hasOwnProperty('isCurrent') && place.isCurrent === true) {
            options.icon = "http://maps.google.com/mapfiles/arrow.png";
            options.shadow = "http://maps.google.com/mapfiles/arrowshadow.png";
        } else if (place.hasOwnProperty('isLocation') && place.isLocation === true) {
            // options.icon = "/assets/marker_location.png";
            options.icon = "/images/marker_location.png";
            if (place.hasOwnProperty('accuracy')) {
                MAPRAMBLE.circle = new google.maps.Circle({
                    center: options.position,
                    radius: place.accuracy,
                    fillColor: "#9999FF",
                    fillOpcity: 0.35,
                    strokeColor: "#6666CC",
                    strokeOpacity: 0.8,
                    strokeWeight: 1,
                    map: options.map
                });
            }
        } else if (place.hasOwnProperty('isCheckin') && place.isCheckin === true) {
            // options.icon = "/assets/marker_checkin.png";
            options.icon = "/images/marker_checkin.png";
        } else if (place.hasOwnProperty('isWayPoint') && place.isWayPoint === true) {
            // options.icon = "/assets/marker_my_map.png";
            options.icon = "/images/marker_my_map.png";
        } else {
            options.icon = "http://maps.google.com/mapfiles/marker.png";
        }

        marker = new google.maps.Marker(options);

        // マーカーにイベントハンドラを設定
        if (place.hasOwnProperty('isLocation')) {
/*
            google.maps.event.addListener(marker, 'click', function () {
                $.mobile.changePage('/locations');
            });
*/
        } else {
            google.maps.event.addListener(marker, 'click', function () {
                return (function (id) {
                    $.mobile.changePage('/places/' + id);
                }(place.id));
            });
        }

        // マーカーを配列に入れる
        if (place.hasOwnProperty('isLocation')) {
            MAPRAMBLE.locationMarker = marker;
        } else {
            MAPRAMBLE.markers.push(marker);
        }
    };

    MAPRAMBLE.outputLocation = function (position, callback) {
        var output, location = {};
        MAPRAMBLE.attempts = 0;

        output = "あなたの位置が確認されました。\n\n";

        output += "緯度:" + position.coords.latitude + "\n";
        output += "経度:" + position.coords.longitude + "\n";
        output += "精度:" + position.coords.accuracy + "m\n";

        location.location = {};
        location.location.latitude = position.coords.latitude;
        location.location.longitude = position.coords.longitude;
        location.location.accuracy = position.coords.accuracy;

        if (position.coords.altitude) {
            output += "高度:" + position.coords.altitude + "m\n";
            location.location.altitude = position.coords.altitude;
        }
        if (position.coords.altitudeAccuracy) {
            output += "高度の精度:" + position.coords.altitudeAccuracy + "m\n";
            location.location.altitudeAccuracy = position.coords.altitudeAccuracy;
        }

        if (position.coords.heading) {
            output += "移動方向:" + position.coords.altitudeAccuracy + "度\n";
            location.location.heading = position.coords.heading;
        }
        if (position.coords.speed) {
            output += "移動速度:" + position.coords.speed + "m/s\n";
            location.location.speed = position.coords.speed;
        }

        output += "取得時刻:" + position.timestamp;
        if (typeof position.timestamp === "number") {
            location.location.timestamp = new Date(position.timestamp);
        } else {
            location.location.timestamp = position.timestamp;
        }

        MAPRAMBLE.console.log(output);
        //location.location.latitude = 35.880736;
        //location.location.longitude = 139.9103;
        //location.location.accuracy = 65.0;

        MAPRAMBLE.location = {};
        MAPRAMBLE.location.lat = location.location.latitude;
        MAPRAMBLE.location.lng = location.location.longitude;
        MAPRAMBLE.location.accuracy = location.location.accuracy;

        $.ajax({
            type: "POST",
            url: "/locations.json",
            data: location,
            dataType: "json"
        }).done(function (data) {
            MAPRAMBLE.console.log('id=' + data.id);
            // MAPRAMBLE.location.id = data.id;
        });
        callback();
    };

    MAPRAMBLE.reportProblem = function (error, callback) {
        var message;
        switch (error.code) {
        case error.PERMISSION_DENIED:
            message = "位置情報にアクセスできません。";
            if (error.hasOwnProperty('message')) {
                message += error.message;
            }
            MAPRAMBLE.console.log(error.message);
            break;
        case error.POSITION_UNAVAILABLE:
            message = "位置情報が利用できません。";
            if (error.hasOwnProperty('message')) {
                message += error.message;
            }
            break;
        case error.TIMEOUT:
            MAPRAMBLE.attempts += 1;
            if (MAPRAMBLE.attempts < 3) {
                MAPRAMBLE.getLocation();
            } else {
                message = "位置情報にアクセスできませんでした。";
                if (error.hasOwnProperty('message')) {
                    message += error.message;
                }
            }
            break;
        default:
            MAPRAMBLE.console.log("Geolocationの定義されていないエラーが発生しました。");
            if (error.hasOwnProperty('message')) {
                message += error.message;
            }
            break;
        }
        MAPRAMBLE.console.log(message);
        alert(message);
        callback();
    };

    MAPRAMBLE.getLocation = function (callback) {
        var geolocation, options;

        geolocation = window.navigator.geolocation;

        // W3C Geolocationに対応しているか
        if (geolocation) {
            options = {
                enableHighAccurary: true,
                timeout: 20000,
                maximumAge: 0
            };

            // 位置情報の取得を試行
            geolocation.getCurrentPosition(
                function (position) {
                    MAPRAMBLE.console.log('success');
                    MAPRAMBLE.outputLocation(position, callback);
                },
                function (error) {
                    MAPRAMBLE.console.log('fail');
                    MAPRAMBLE.reportProblem(error, callback);
                },
                options
            );
        } else {
            MAPRAMBLE.console.log('not available');
            MAPRAMBLE.console.log('ブラウザが位置情報に対応していません。');
            callback();
        }
    };

    MAPRAMBLE.watchPosition = function () {
        var geolocation, options, watchId;

        geolocation = window.navigator.geolocation;

        // W3C Geolocationに対応しているか
        if (geolocation) {
            options = {
                enableHighAccurary: true,
                timeout: 45000
            };

            // 位置情報の取得を試行
            watchId = geolocation.watchPosition(
                MAPRAMBLE.outputLocation,
                MAPRAMBLE.reportProblem,
                options
            );
        } else {
            MAPRAMBLE.console.log('ブラウザが位置情報に対応していません。');
        }
        return watchId;
    };

    // 現在位置マーカーを追加
    MAPRAMBLE.addLocationMarker = function () {
        var location = MAPRAMBLE.location;
        location.isLocation = true;
        MAPRAMBLE.addMarker(location);
    };

    // 現在位置をマップの中心に設定する
    MAPRAMBLE.setLocationCenter = function () {
        MAPRAMBLE.map.setCenter(new google.maps.LatLng(MAPRAMBLE.location.lat, MAPRAMBLE.location.lng));
    };

    // ボタンに帯するイベントハンドラの設定
    MAPRAMBLE.setEventHandler = function () {
        $('#calcRoute').click(function (event) {
            MAPRAMBLE.calcRoute();
            event.preventDefault();
        });

        $('#getLocation').click(function (event) {
            MAPRAMBLE.getLocation(function () {
                MAPRAMBLE.deleteLocationMarker();
                MAPRAMBLE.addLocationMarker();
                MAPRAMBLE.setLocationCenter();
            });
            event.preventDefault();
        });
    };

    // 画面サイズに合わせて高さを設定
    MAPRAMBLE.setHeight = function () {
        var viewportHeight, mapHeight;
        viewportHeight = window.innerHeight || $(window).height();
        mapHeight = viewportHeight - $('#header').outerHeight() - 15 * 2;
        $('#mapCanvas').css('height', mapHeight);
        MAPRAMBLE.console.log('mapHeight: ' + mapHeight);
    };


    MAPRAMBLE.calcRoute = function () {
        MAPRAMBLE.console.log('calcing');
        var options, request, pointsNumber, directionsService, place, origin, destination, waypoints, i;
        waypoints = [];
        pointsNumber = MAPRAMBLE.way_points.length;
        if (pointsNumber < 2) {
            MAPRAMBLE.console.log(pointsNumber);
            alert('ルートを求めるには、マイマップに少なくとも2点以上の場所を追加してください。');
        } else if (pointsNumber > 8) {
            MAPRAMBLE.console.log(pointsNumber);
            alert('ルートを求めるには、マイマップに登録する場所を8点以下にしてください。');
        } else {
            options = {
                map: MAPRAMBLE.map,
                suppressMarkers: true
            };

            directionsService = new google.maps.DirectionsService();
            MAPRAMBLE.directionsRenderer = new google.maps.DirectionsRenderer(options);

            place = MAPRAMBLE.places[MAPRAMBLE.way_points[0]];
            origin = new google.maps.LatLng(place.lat, place.lng);
            for (i = 1; i < pointsNumber - 1; i = i + 1) {
                place = MAPRAMBLE.places[MAPRAMBLE.way_points[i]];
                waypoints.push({ location: new google.maps.LatLng(place.lat, place.lng)});
            }
            place = MAPRAMBLE.places[MAPRAMBLE.way_points[pointsNumber - 1]];
            destination = new google.maps.LatLng(place.lat, place.lng);
            request = {
                origin: origin,
                destination: destination,
                waypoints: waypoints,
                travelMode: google.maps.DirectionsTravelMode.WALKING,
                optimizeWaypoints: true
            };
            directionsService.route(request, function (responce, status) {
                MAPRAMBLE.console.log(responce);
                if (status === google.maps.DirectionsStatus.OK) {
                    MAPRAMBLE.directionsRenderer.setDirections(responce);
                    MAPRAMBLE.console.log(responce.routes[0].waypoint_order);
                }
            });
        }
    };

    // メイン・プログラム
    $(document).on('pageshow', "#map", function () {
        // 位置情報取得の試行回数
        MAPRAMBLE.attemps = 0;

        MAPRAMBLE.setHeight();
        MAPRAMBLE.setEventHandler();
        if (MAPRAMBLE.hasOwnProperty('location') === false) {
            MAPRAMBLE.getLocation(function () {
                MAPRAMBLE.addLocationMarker();
            });
        }
        MAPRAMBLE.setInitial();
        MAPRAMBLE.createMap();
        MAPRAMBLE.addPlaceMarkers();
    });

}());
