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

part of google_maps;

class PolyMouseEvent extends MouseEvent {
  static PolyMouseEvent cast(js.Proxy proxy) => proxy == null ? null : new PolyMouseEvent.fromProxy(proxy);

  PolyMouseEvent.fromProxy(js.Proxy proxy) : super.fromProxy(proxy);

  num get edge => $unsafe['edge'];
  num get path => $unsafe['path'];
  num get vertex => $unsafe['vertex'];
  set edge(num edge) => $unsafe['edge'] = edge;
  set path(num path) => $unsafe['path'] = path;
  set vertex(num vertex) => $unsafe['vertex'] = vertex;
}