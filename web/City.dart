library City;

import 'package:google_maps/google_maps.dart';

class City {
  String name;
  LatLng coordinate;
  DateTime date;

  City(this.name, this.coordinate, this.date);
  
  String getName() {
    return this.name;
  }
  
  LatLng getCoordinate() {
    return coordinate;
  }
  
  DateTime getDate() {
    return this.date;
  }
}