library LocationInfo;

import 'package:google_maps/google_maps.dart';

class LocationInfo {
  String name;
  LatLng coordinate;
  DateTime date;
  String iconMarker;

  LocationInfo(this.name, this.coordinate, this.date, this.iconMarker);
  
  String getName() {
    return this.name;
  }
  
  LatLng getCoordinate() {
    return coordinate;
  }
  
  DateTime getDate() {
    return this.date;
  }
  
  String getIconMarker() {
    return this.iconMarker;
  }
}