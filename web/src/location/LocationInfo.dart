library LocationInfo;

import 'dart:collection';
import 'dart:core';
import 'package:google_maps/google_maps.dart';

class LocationInfo {
  String name;
  LatLng coordinate;
  DateTime date;
  String iconMarker;

  LocationInfo(this.name, this.coordinate, this.date, this.iconMarker);
  
  LocationInfo.from(LinkedHashMap itemSerialize) {
    this.name = itemSerialize["name"];
    this.coordinate = new LatLng(double.parse(itemSerialize["lat"]), double.parse(itemSerialize["lng"]));
    this.date = new DateTime(int.parse(itemSerialize["year"]), int.parse(itemSerialize["month"]), int.parse(itemSerialize["day"]));
    this.iconMarker = itemSerialize["icon"];
  }
  
  
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
  
  String toJSON() {
    String res = "{" + "\"name\":\"" + this.name + "\", \"lat\":\"" + this.coordinate.lat.toString() + "\", \"lng\":\"" + this.coordinate.lng.toString();
    res += "\", \"year\":\"" + this.date.year.toString();
    res += "\", \"month\":\"" + this.date.month.toString();
    res += "\", \"day\":\"" + this.date.day.toString();
    res += "\", \"hour\":\"" + this.date.hour.toString();
    res += "\", \"minute\":\"" + this.date.minute.toString();
    res += "\", \"icon\":\"" + this.iconMarker + "\"}";
    return res;
  }
}