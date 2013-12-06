library Aeroport;

import 'LocationInfo.dart';

class Aeroport extends LocationInfo {
  Aeroport(name, coordinate, date) : super("Aeroport de " + name, coordinate, date, "images/icon-avion.png");
}