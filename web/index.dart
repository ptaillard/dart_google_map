// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:google_maps/google_maps.dart';
import 'CityFactory.dart';
import 'TravelManager.dart';


GMap map;
TravelManager travelManager;

void main() {
  initGoogleMap();
 
  travelManager = new TravelManager(map);
  
  travelManager.appendArrivalCity(CityFactory.create('San Francisco', new LatLng(37.800101,-122.433132), new DateTime(2013, 06, 16)));
  travelManager.appendArrivalCity(CityFactory.create('Barstow', new LatLng(34.844414,-117.084357), new DateTime(2013, 06, 20)));
  travelManager.appendArrivalCity(CityFactory.create('Kingman', new LatLng(35.202428,-114.055359), new DateTime(2013, 06, 21)));
  travelManager.appendArrivalCity(CityFactory.create('Grand Canyon', new LatLng(36.061034,-112.142311), new DateTime(2013, 06, 22)));
  travelManager.appendArrivalCity(CityFactory.create('Monument Valley', new LatLng(37.000668,-110.173627), new DateTime(2013, 06, 26)));
  
  travelManager.computeRoute();
}

void initGoogleMap() {
  
  final SanFrancisco = new LatLng(37.781298,-122.418648);
  final mapOptions = new MapOptions()
    ..zoom = 7
    ..mapTypeId = MapTypeId.ROADMAP
    ..center = SanFrancisco
    ;
  map = new GMap(querySelector("#map-canvas"), mapOptions);
}
