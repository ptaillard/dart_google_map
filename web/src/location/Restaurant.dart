library Restaurant;

import 'LocationInfo.dart';

class Restaurant extends LocationInfo {
  Restaurant(name, coordinate, date) : super(name, coordinate, date, "images/icon-restaurant.png");
}