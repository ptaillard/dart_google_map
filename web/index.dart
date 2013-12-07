// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:google_maps/google_maps.dart';
import 'LocationFactory.dart';
import 'TravelManager.dart';

import 'package:intl/date_symbol_data_local.dart';


GMap map;


void main() {
  initializeDateFormatting("fr_FR", null).then((_) => launchApp());
  
}

void launchApp() {
  initGoogleMap();
  TravelManager travelManager;
  travelManager = new TravelManager(map);
  
  travelManager.appendLocation(LocationFactory.createAeroport('San Francisco', new LatLng(37.616407,-122.386507), new DateTime(2013, 06, 16)));//Coventry Motor Inn
  travelManager.appendLocation(LocationFactory.createCity('San Francisco', new LatLng(37.800165,-122.433116), new DateTime(2013, 06, 16)));//Coventry Motor Inn
  travelManager.appendLocation(LocationFactory.createRestaurant('Resto', new LatLng(38.800165,-122.433116), new DateTime(2013, 06, 16)));
  travelManager.appendLocation(LocationFactory.createCity('Barstow', new LatLng(34.844601,-117.08438), new DateTime(2013, 06, 22)));
  travelManager.appendLocation(LocationFactory.createVisit('Calico', new LatLng(34.9498,-116.864111), new DateTime(2013, 06, 22)));
  travelManager.appendLocation(LocationFactory.createCity('Kingman', new LatLng(35.21126,-114.016511), new DateTime(2013, 06, 23)));
  travelManager.appendLocation(LocationFactory.createCity('Grand Canyon', new LatLng(36.054598,-112.119729), new DateTime(2013, 06, 24)));
  travelManager.appendLocation(LocationFactory.createCity('Monument Valley', new LatLng(36.726365,-110.254864), new DateTime(2013, 06, 27)));
  travelManager.appendLocation(LocationFactory.createCity('Page', new LatLng(36.916514,-111.45511), new DateTime(2013, 06, 28)));
  travelManager.appendLocation(LocationFactory.createCity('Bryce Canyon', new LatLng(37.674181,-112.158279), new DateTime(2013, 06, 29)));
  travelManager.appendLocation(LocationFactory.createCity('Zion Canyon', new LatLng(37.180193,-113.006714), new DateTime(2013, 07, 03)));
  travelManager.appendLocation(LocationFactory.createCity('Las Vegas', new LatLng(36.098181,-115.167416), new DateTime(2013, 07, 04)));
  travelManager.appendLocation(LocationFactory.createCity('Los Angeles', new LatLng(34.103339,-118.340587), new DateTime(2013, 07, 08)));
  travelManager.appendLocation(LocationFactory.createAeroport('Los Angeles', new LatLng(33.942719,-118.408169), new DateTime(2013, 07, 10)));
  
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
