library TravelManager;

import 'dart:collection';
import 'package:google_maps/google_maps.dart';
import 'LocationInfo.dart';
import 'LocationMarker.dart';
import 'LocationSelect.dart';
import 'City.dart';

class TravelManager {
  GMap map;
  LocationMarker marker;
  LocationSelect placeSelect;
  LinkedHashMap<int, LocationInfo> locationInfos;
  
  TravelManager(this.map){
    this.locationInfos = new LinkedHashMap();
    this.marker = new LocationMarker(this.map);
    this.placeSelect = new LocationSelect(this, this.map);
  }
  
  void appendLocation(LocationInfo location) {
    if(location is City) {
      if(locationInfos.isNotEmpty) {
        LocationInfo previousCity = locationInfos[locationInfos.keys.last];
        placeSelect.appendSelectionRouteFromTo(previousCity, location);
      }
      locationInfos[location.hashCode] = location;
    }
    marker.appendOn(location);
  }
  
  void computeRoute() {
    placeSelect.computeRoute(locationInfos[locationInfos.keys.first], locationInfos[locationInfos.keys.last]);
  }

  LocationInfo getLocation(int hashcode) {
    return locationInfos[hashcode];
  }
}