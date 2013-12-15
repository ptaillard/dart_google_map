
import 'dart:html';
import 'package:google_maps/google_maps.dart';
import 'LocationFactory.dart';
import 'TravelManager.dart';

class ActionsMapManager {
  
  GMap map;
  TravelManager travelManager;
  int action = 0;
  
  ActionsMapManager(TravelManager travelManager, GMap map) {
    this.travelManager = travelManager;
    this.map = map;
    initEvent();
  }
  
  void initEvent() {
    map.onRightclick.listen((e) => afficheMenu(e));
    map.onClick.listen((e) => cacheMenu(e));
    querySelector('#move').onClick.listen((e) => actionUserMove(e));
    querySelector('#ville').onClick.listen((e) => actionUserVille(e));
    querySelector('#aeroport').onClick.listen((e) => actionUserAeroport(e));
  }

  
  void afficheMenu(e) {
    querySelector('#infos')..text = 'Menu';
  }

  void actionUserVille(e) {
    action = 1;
    querySelector('#infos')..text = 'Action ville';
  }

  void actionUserAeroport(e) {
    action = 2;
    querySelector('#infos')..text = 'Action aeroport';
  }

  void actionUserMove(e) {
    action = 0;
    querySelector('#infos')..text = 'Action move';
  }

  void cacheMenu(e) {
    querySelector('#infos')..text = '';
    if(action == 1) {
      travelManager.appendLocation(LocationFactory.createCity('city', e.latlng(), new DateTime(2013, 06, 16)));
    }
    else {
      travelManager.appendLocation(LocationFactory.createAeroport('aeroport', e.latlng(), new DateTime(2013, 06, 16)));
    }
  }
}
