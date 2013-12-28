library GoogleDriveManager;

import 'dart:html';
import 'EtatIdentificationListener.dart';
import 'files.dart';

import "package:google_drive_v2_api/drive_v2_api_browser.dart" as drivelib;
import "package:google_drive_v2_api/drive_v2_api_client.dart" as client;
import '../TravelManager.dart';
import 'UserIdentification.dart';

class GoogleDriveManager extends EtatIdentificationListener {
  
  drivelib.Drive drive = null;
  UserIdentification userIdentification = null;
  final InputElement fileId = querySelector("#fileId");
  final DivElement output = querySelector('#drive');
  final DivElement displayListDrive = querySelector('#display-list-drive');
  final AnchorElement listDriveElement = querySelector('#listdrive'); 
  final AnchorElement createDriveFile = querySelector('#createdrive'); 
  final AnchorElement loadDriveFile = querySelector('#loaddrive'); 
  final InputElement filename = querySelector("#filename");
  final InputElement filetoload = querySelector("#filetoload");
  final DivElement infoCarteSelection = querySelector('#info-carte-selection'); 
  var token = null;
  TravelManager travelManager;

  GoogleDriveManager(TravelManager travelManager){
    infoCarteSelection.hidden = true;
    this.userIdentification = new UserIdentification();
    this.userIdentification.addListener(this);
    this.travelManager = travelManager;
  }
  
  void authentification(auth) {
    this.drive = new drivelib.Drive(auth);
    this.drive.makeAuthRequests = true;
    listDriveElement.onClick.listen((e){
      _list(e);
    });
    createDriveFile.onClick.listen((e){
      String filenameToSave = _getFilename();
      _create(e, filenameToSave);
    });
    loadDriveFile.onClick.listen((e){
      _lireFichier(e);
    });
  }
  
  String _getFilename() {
    return filename.value; 
   
  }
  
  void login(token) {
    this.token = token;
    output.innerHtml = token.toString();
  }

  void logout() {
    this.token = null;
    output..innerHtml = "<b>drive deconnect</b>";
  }

  void _create(Event evt, String filenameToSave) {
    var contentType = 'application/octet-stream';
    var charcodes = travelManager.toJSON();
    var base64Data = window.btoa(charcodes);
    
    var newFile = new client.File.fromJson({"title": filenameToSave, "mimeType": contentType});
    drive.files.insert(newFile, content: base64Data, contentType: contentType)
      .then((data) {
        output..appendHtml("Uploaded file with ID <a href=\"${data.alternateLink}\" target=\"_blank\">${data.id}</a><br>");
      })
        .catchError((e) {
          output..appendHtml("$e<br>");
          return true;
        });

  }
  
  void _lireFichier(Event evt) {
    var fileid = filetoload.value;
    drive.files.get(fileid).then((data) {
      output.appendHtml("Got $fileid<br><br>");
      output..appendHtml("Content file = " + data.downloadUrl);
      _makeRequest(data.downloadUrl);
      infoCarteSelection.hidden = false;
    })
    .catchError((e) {
      output..appendHtml("$e<br>");
    });
  }
  
  void _makeRequest(String urlDownload) {
    HttpRequest httpRequest = new HttpRequest();
    httpRequest
        ..open('GET', urlDownload)
        ..setRequestHeader("Content-type", "application/octet-stream")
        ..setRequestHeader("Authorization", "Bearer " + token.data)
        ..onLoadEnd.listen((e) => _requestComplete(httpRequest))
        ..send(""); // Preparing the http request and send to server
  }

  void _requestComplete(HttpRequest request) {
    if (request.status == 200) {
      travelManager.fromJSON(request.responseText);
    } else {
      output..innerHtml = "Request failed, status={" + request.status.toString() + "}";
    }
  }
  
  bool isLogged() {
    return token != null;
  }
  /*
  void _get(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      get_file(token, _fileId).then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _insert(e) {
    if(isLogged()) {
      insert_file(token, "New File Example").then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _delete(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      delete_file(token, _fileId, output).then((file){
        fileId.value = "";
        output.text = "Deleted File: $_fileId";
      });
    }
  }
  
  void _copy(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      copy_file(token, _fileId).then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }*/
  
  void _list(e){
    displayListDrive.innerHtml = '';
    if(isLogged()) {
     // list_files(token, "mimeType = 'application/vnd.google-apps.document' AND trashed = false").then((fileList){
      list_files(token, "mimeType = 'application/octet-stream' AND trashed = false").then((fileList){
        fileList.items.forEach((client.File file){
          displayListDrive.appendHtml("<div><a target='_blank' href='${file.alternateLink}'>${file.title}</a>: ${file.id}</div>");
        });
      });
    }
  }
  /*
  void _patch(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      patch_file(token, _fileId, "New File Example2").then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _touch(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      touch_file(token, _fileId).then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _trash(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      trash_file(token, _fileId).then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _untrash(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      untrash_file(token, _fileId).then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }
  
  void _update(e) {
    if(isLogged()) {
      var _fileId = fileId.value;
      update_file(token, _fileId,"All Work and No Play Makes Jack a dull boy.").then((file){
        fileId.value = file.id;
        output.text = file.toString();
      });
    }
  }*/
  
}