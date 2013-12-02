// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:google_maps/google_maps.dart';
import 'City.dart';

final DirectionsService directionsService = new DirectionsService();
DirectionsRenderer directionsDisplay;
GMap map;

void main() {
  initGoogleMap();
 

  City sanFrancisco = new City('San Francisco', new LatLng(37.781298,-122.418648));
  City barstow = new City('Barstow', new LatLng(34.911273,-117.015488));
  City kingman = new City('Kingman', new LatLng(35.202428,-114.055359));
  City grandCanyon = new City('Grand Canyon', new LatLng(36.061034,-112.142311));
  City monumentValley = new City('Monument Valley', new LatLng(37.000668,-110.173627));

  addMarkerOnCity(map, sanFrancisco.getCoordinate(), sanFrancisco.getName(), '16 Juin');
  addMarkerOnCity(map, barstow.getCoordinate(), barstow.getName(), '20 Juin');
  addMarkerOnCity(map, kingman.getCoordinate(), kingman.getName(), '21 Juin');
  addMarkerOnCity(map, grandCanyon.getCoordinate(), grandCanyon.getName(), '22 Juin');
  addMarkerOnCity(map, monumentValley.getCoordinate(), monumentValley.getName(), '26 Juin');
  
  addAllCity(sanFrancisco, monumentValley);
  addOptionStartCity(sanFrancisco, barstow);
  addOptionStartCity(barstow, kingman);
  addOptionStartCity(kingman, grandCanyon);
  addOptionStartCity(grandCanyon, monumentValley);
  
  
  querySelector('#startcity').onChange.listen((e) => computeRoute());
  
  computeRoute();
}

void addAllCity(City cityFrom, City cityTo) {
  querySelector("#startcity").appendHtml('<option value="" data-latstart="' +  
      cityFrom.getCoordinate().lat.toString() + '" data-lngstart="' +  
      cityFrom.getCoordinate().lng.toString() + '" data-latend="' +  
      cityTo.getCoordinate().lat.toString() + '" data-lngend="' +  
      cityTo.getCoordinate().lng.toString() + '">' + 'Tout' + '</option>');
}

void addOptionStartCity(City cityFrom, City cityTo) {
  querySelector("#startcity").appendHtml('<option value="" data-latstart="' +  
      cityFrom.getCoordinate().lat.toString() + '" data-lngstart="' +  
      cityFrom.getCoordinate().lng.toString() + '" data-latend="' +  
      cityTo.getCoordinate().lat.toString() + '" data-lngend="' +  
      cityTo.getCoordinate().lng.toString() + '">' + cityFrom.getName() + ' -> '+ cityTo.getName() + '</option>');
}

void initGoogleMap() {
  directionsDisplay = new DirectionsRenderer();
  final SanFrancisco = new LatLng(37.781298,-122.418648);
  final mapOptions = new MapOptions()
    ..zoom = 7
    ..mapTypeId = MapTypeId.ROADMAP
    ..center = SanFrancisco
    ;
  map = new GMap(querySelector("#map-canvas"), mapOptions);
  directionsDisplay.map = map;
}

void computeRoute() {
  final element1 = querySelector('#startcity') as SelectElement;
  final el = element1.selectedOptions[0];
  
  final lats = double.parse(el.attributes['data-latstart']);
  final lngs = double.parse(el.attributes['data-lngstart']);
  final late = double.parse(el.attributes['data-latend']);
  final lnge = double.parse(el.attributes['data-lngend']);
  
 DirectionsRequest directionsRequest = new DirectionsRequest()
    ..origin = new LatLng(lats, lngs)
    ..destination = new LatLng(late, lnge)
    ..travelMode = TravelMode.DRIVING;
  
  directionsService.route(directionsRequest, displayRoute);
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


void displayRoute(DirectionsResult results, DirectionsStatus status) {
  if(status == DirectionsStatus.OK) {
    directionsDisplay.directions = results;
  }
  querySelector("#infos")..text = status.value;
}
