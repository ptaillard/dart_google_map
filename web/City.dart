import 'package:google_maps/google_maps.dart';

class City {
  String name;
  LatLng coordinate;

  City(this.name, this.coordinate);
  
  String getName() {
    return this.name;
  }
  
  LatLng getCoordinate() {
    return coordinate;
  }
}