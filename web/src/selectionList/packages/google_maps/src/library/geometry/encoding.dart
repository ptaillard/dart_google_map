// Copyright (c) 2012, Alexandre Ardhuin
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of google_maps_geometry;

final Encoding encoding = new Encoding();

class Encoding extends jsw.TypedProxy {
  static Encoding cast(js.Proxy proxy) => proxy == null ? null : new Encoding.fromProxy(proxy);

  Encoding() : super.fromProxy(maps.geometry.encoding);
  Encoding.fromProxy(js.Proxy proxy) : super.fromProxy(proxy);

  List<LatLng> decodePath(String encodedPath) => jsw.JsArrayToListAdapter.castListOfSerializables($unsafe.decodePath(encodedPath), LatLng.cast);
  String encodePath(dynamic/*Array.<LatLng>|MVCArray.<LatLng>*/ path) => $unsafe.encodePath(path is List<LatLng> ? jsifyList(path) : path);
}