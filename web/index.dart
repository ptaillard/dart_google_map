// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library google_maps;

// This code is derived from
// https://developers.google.com/maps/documentation/javascript/tutorial#HelloWorld
// You can view the original JavaScript example at
// https://developers.google.com/maps/documentation/javascript/examples/map-simple
import 'dart:html';
import 'package:google_maps/google_maps.dart';

void main() {
  final mapOptions = new MapOptions()
    ..zoom = 8
    ..center = new LatLng(37.781298,-122.418648)
    ..mapTypeId = MapTypeId.ROADMAP
    ;
  final map = new GMap(querySelector("#map-canvas"), mapOptions);
  
  LatLng coordinate = new LatLng(37.781298,-122.418648); 
  addMarkerOnCity(map, coordinate, 'San Francisco', '16 Juin');

  LatLng coordinateBarstow = new LatLng(34.905642,-117.018921); 
  addMarkerOnCity(map, coordinateBarstow, 'Barstow', '20 Juin');

}

void addMarkerOnCity(map, coordinate, city, date) {
   var marker = new Marker(
      new MarkerOptions()
      ..position = coordinate
      ..map = map
      ..title = city
  );
  
  var content = new DivElement();
  var cityText = '<span class="colorCity"><b>' + city + '</b></span><p>le ' + date + '</p>'; 
  content.innerHtml = cityText;
  
  var infoWindow = new InfoWindow(
    new InfoWindowOptions()
      ..content = content
  );
  
  marker.onClick.listen((e) {
    infoWindow.open(map, marker);
  });
}
