// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:typed_data";
import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:google_maps/google_maps.dart';
import 'src/location/LocationFactory.dart';
import 'src/TravelManager.dart';
import 'src/actionsMap/ActionsMapManager.dart';
import 'src/files.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'package:google_drive_v2_api/drive_v2_api_browser.dart' as drivelib;
import "package:google_drive_v2_api/drive_v2_api_client.dart" as client;
import "package:google_oauth2_client/google_oauth2_browser.dart" as oauth;

void main() {
  initializeDateFormatting("fr_FR", null).then((_) => launchApp());
}

final CLIENT_ID = "796343192238.apps.googleusercontent.com";
final SCOPES = [drivelib.Drive.DRIVE_FILE_SCOPE];
var auth = new oauth.GoogleOAuth2(CLIENT_ID, SCOPES);
var drive = new drivelib.Drive(auth);
var login = querySelector('#login') as ButtonElement; 
var logout = querySelector('#logout') as ButtonElement;
final InputElement fileId = querySelector("#fileId");
final DivElement output = querySelector('#drive');

void launchApp() {
  GMap map = initGoogleMap();
  
  TravelManager travelManager;
  travelManager = new TravelManager(map);
  
  travelManager.appendLocation(LocationFactory.createAeroport('San Francisco', new LatLng(37.616407,-122.386507), new DateTime(2013, 06, 16)));//Coventry Motor Inn
  travelManager.appendLocation(LocationFactory.createCity('San Francisco', new LatLng(37.800165,-122.433116), new DateTime(2013, 06, 16)));//Coventry Motor Inn
  travelManager.appendLocation(LocationFactory.createCity('Barstow', new LatLng(34.844601,-117.08438), new DateTime(2013, 06, 22)));
  travelManager.appendLocation(LocationFactory.createVisit('Calico', new LatLng(34.9498,-116.864111), new DateTime(2013, 06, 22)));
  travelManager.appendLocation(LocationFactory.createCity('Kingman', new LatLng(35.21126,-114.016511), new DateTime(2013, 06, 23)));
  travelManager.appendLocation(LocationFactory.createCity('Grand Canyon', new LatLng(36.054598,-112.119729), new DateTime(2013, 06, 24)));
  travelManager.appendLocation(LocationFactory.createCity('Monument Valley', new LatLng(36.726365,-110.254864), new DateTime(2013, 06, 27)));
  travelManager.appendLocation(LocationFactory.createCity('Page', new LatLng(36.916514,-111.45511), new DateTime(2013, 06, 28)));
  travelManager.appendLocation(LocationFactory.createCity('Bryce Canyon', new LatLng(37.674181,-112.158279), new DateTime(2013, 06, 29)));
  travelManager.appendLocation(LocationFactory.createCity('Zion Canyon', new LatLng(37.180193,-113.006714), new DateTime(2013, 07, 03)));
  travelManager.appendLocation(LocationFactory.createCity('Las Vegas', new LatLng(36.098181,-115.167416), new DateTime(2013, 07, 04)));
  travelManager.appendLocation(LocationFactory.createCity('Los Angeles', new LatLng(34.103339,-118.340587), new DateTime(2013, 07, 08)));
  travelManager.appendLocation(LocationFactory.createAeroport('Los Angeles', new LatLng(33.942719,-118.408169), new DateTime(2013, 07, 10)));
  
  travelManager.computeRoute();
  
  ActionsMapManager actionsMapManager = new ActionsMapManager(travelManager, map);
  
  
  drive.makeAuthRequests = true;
  querySelector('#filepicker').onChange.listen(ajouteFichier);
  login.onClick.listen((e){
    _getToken().then((token){
      querySelector('#filepicker').style.display = "block";
      login..disabled = true;
      logout..disabled = false;
    });
  });
  
  querySelector('#logout').onClick.listen((e){
    deconnect(e);
  });
}

void deconnect(e) {
  auth.logout();
  login..disabled = false;
  logout..disabled = true;
  querySelector('#filepicker').style.display = "none";
  querySelector('#drive')..innerHtml = "<b>drive deconnect</b>";
}

void connect(e) {
  auth.login(immediate: false).then((token) {
    querySelector('#drive').appendHtml("Got Token ${token.type} ${token.data}<br>");
    querySelector('#filepicker').style.display = "block";
  });
}

Future <oauth.Token> _getToken(){
  var completer = new Completer();
  auth.login(immediate: false).then((token) {
    completer.complete(token);
  });
  return completer.future;
}
/*
Future <oauth.Token> _getToken(){
  var completer = new Completer();
  var clientId = window.localStorage["client_id"];
  var auth = new oauth.GoogleOAuth2(clientId, SCOPES);

  if (!window.localStorage.containsKey('token')){
    auth.login().then((oauth.Token token) {
      window.localStorage["token"] = token.toJson();
      completer.complete(token);
    });
  } else {
    Map map = JSON.decode(window.localStorage["token"]);
    var type = map["type"];
    var data = map["data"];
    var expiry = new DateTime.fromMillisecondsSinceEpoch(map['expiry']);
    var token = new oauth.Token(type,data,expiry);
    var request = new HttpRequest();
    request.open("GET", "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=$data");
    request.onLoad.listen((e){
      if(request.status == 200) {
        var token = new oauth.Token(type,data,expiry);
        completer.complete(token);
      }else
      {
        auth.login().then((oauth.Token token) {
          window.localStorage["token"] = token.toJson();
          completer.complete(token);
        });
      }
    });
    try {
      request.send();
    } catch(e){
      auth.login().then((oauth.Token token) {
        window.localStorage["token"] = token.toJson();
        completer.complete(token);
      });
    }
  }
  return completer.future;
}*/

void ajouteFichier(Event evt) {
  //"C:\paysage.jpg"
  var file = (evt.target as InputElement).files[0];
  var reader = new FileReader();
  reader.readAsArrayBuffer(file);
  reader.onLoad.listen((Event e) {
    var contentType = file.type;
    contentType = 'application/octet-stream';

    var uintlist = new Uint8List.fromList(reader.result);
    var charcodes = new String.fromCharCodes(uintlist);
    var base64Data = window.btoa(charcodes);
    var newFile = new client.File.fromJson({"title": file.name, "mimeType": contentType});
    querySelector('#drive')..appendHtml("Uploading file...<br>");
    drive.files.insert(newFile, content: base64Data, contentType: contentType)
      .then((data) {
        querySelector('#drive')..appendHtml("Uploaded file with ID <a href=\"${data.alternateLink}\" target=\"_blank\">${data.id}</a><br>");
      })
        .catchError((e) {
          querySelector('#drive')..appendHtml("$e<br>");
          return true;
        });

    });
}


void _get(e) {
  _getToken().then((token){
    var _fileId = fileId.value;
    get_file(token, _fileId).then((file){
      fileId.value = file.id;
      output.text = file.toString();
    });
  });
}

void _insert(e) {
  _getToken().then((token){
    insert_file(token, "New File Example").then((file){
      fileId.value = file.id;
      output.text = file.toString();
    });
  });
}

void _delete(e) {
  _getToken().then((token){
    var _fileId = fileId.value;
    delete_file(token, _fileId, output).then((file){
      fileId.value = "";
      output.text = "Deleted File: $_fileId";
    });
  });
}

void _copy(e) {
  _getToken().then((token){
    var _fileId = fileId.value;
    copy_file(token, _fileId).then((file){
      fileId.value = file.id;
      output.text = file.toString();
    });
  });
}

void _list(e){
  _getToken().then((token){
    list_files(token, "mimeType = 'application/vnd.google-apps.document' AND trashed = false").then((fileList){
      output.innerHtml = '';
      fileId.value = '';
      fileList.items.forEach((client.File file){
        output.appendHtml("<div><a target='_blank' href='${file.alternateLink}'>${file.title}</a>: ${file.id}</div>");
      });
    });
  });
}

void _patch(e) {
  _getToken().then((token){
    var _fileId = fileId.value;
    patch_file(token, _fileId, "New File Example2").then((file){
      fileId.value = file.id;
      output.text = file.toString();
    });
  });
}

void _touch(e) {
  _getToken().then((token){
    var _fileId = fileId.value;
    touch_file(token, _fileId).then((file){
      fileId.value = file.id;
      output.text = file.toString();
    });
  });
}

void _trash(e) {
  _getToken().then((token){
    var _fileId = fileId.value;
    trash_file(token, _fileId).then((file){
      fileId.value = file.id;
      output.text = file.toString();
    });
  });
}

void _untrash(e) {
  _getToken().then((token){
    var _fileId = fileId.value;
    untrash_file(token, _fileId).then((file){
      fileId.value = file.id;
      output.text = file.toString();
    });
  });
}

void _update(e) {
  _getToken().then((token){
    var _fileId = fileId.value;
    update_file(token, _fileId,"All Work and No Play Makes Jack a dull boy.").then((file){
      fileId.value = file.id;
      output.text = file.toString();
    });
  });
}



GMap initGoogleMap() {
  
  final SanFrancisco = new LatLng(37.781298,-122.418648);
  final mapOptions = new MapOptions()
    ..zoom = 7
    ..mapTypeId = MapTypeId.ROADMAP
    ..center = SanFrancisco;
  return new GMap(querySelector("#map-canvas"), mapOptions);
}
