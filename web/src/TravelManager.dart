library TravelManager;

import 'dart:collection';
import 'dart:convert';
import 'package:google_maps/google_maps.dart';
import 'location/LocationInfo.dart';
import 'location/LocationMarker.dart';
import 'selectionList/LocationSelect.dart';
import 'selectionList/DateSelect.dart';
import 'RouteGenerator.dart';


class TravelManager {
  GMap map;
  LocationMarker marker;
  LocationSelect locationSelect;
  DateSelect dateSelect;
  LinkedHashMap<int, LocationInfo> locationInfos;
  RouteGenerator routeGenerator;
  
  TravelManager(this.map){
    this.locationInfos = new LinkedHashMap();
    this.marker = new LocationMarker(this.map);
    this.routeGenerator = new RouteGenerator(this, this.map);
    this.locationSelect = new LocationSelect(this.routeGenerator);
    this.dateSelect = new DateSelect(this.routeGenerator);
  }
  
  void appendLocation(LocationInfo location) {
    if(locationInfos.isNotEmpty) {
      LocationInfo previousCity = locationInfos[locationInfos.keys.last];
      locationSelect.appendSelectionRouteFromTo(previousCity, location);
      dateSelect.appendSelectionRouteFromTo(previousCity, location);
    }
    locationInfos[location.hashCode] = location;
    marker.appendOn(location);
  }
  
  void computeRoute() {
    locationSelect.computeRoute(locationInfos[locationInfos.keys.first], locationInfos[locationInfos.keys.last]);
    dateSelect.computeRoute(locationInfos[locationInfos.keys.first], locationInfos[locationInfos.keys.last]);
  }

  LocationInfo getLocation(int hashcode) {
    return locationInfos[hashcode];
  }
  
  String toJSON() {
    String travel = "[";
    bool first = true;
/*"""
      [{"Dis":1111.1,"Flag":0,"Obj":{"ID":1,"Title":"Volvo 140"}},
      {"Dis":2222.2,"Flag":0,"Obj":{"ID":2,"Title":"Volvo 240"}}]""";*/
    for(int key in locationInfos.keys) {
      if(first) {
        first = false;
      } else {
        travel += ",";
      }
      travel += "{" + key.toString() + ":";
      travel += locationInfos[key].toJSON();
      travel += "}";
    }
    travel += "]";
    print(travel);
    return travel;
  }
  
  void fromJSON(String jsonToParse) {
    locationInfos = JSON.decode(jsonToParse);
  }
}