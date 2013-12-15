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

part of google_maps_places;

class PlaceReview extends jsw.TypedProxy {
  static PlaceReview cast(js.Proxy proxy) => proxy == null ? null : new PlaceReview.fromProxy(proxy);

  PlaceReview() : super();
  PlaceReview.fromProxy(js.Proxy proxy) : super.fromProxy(proxy);

  List<PlaceAspectRating> get aspects => jsw.JsArrayToListAdapter.castListOfSerializables($unsafe['aspects'], PlaceAspectRating.cast);
  String get authorName => $unsafe['author_name'];
  String get authorUrl => $unsafe['author_url'];
  String get text => $unsafe['text'];
  set aspects(List<PlaceAspectRating> aspects) => $unsafe['aspects'] = jsifyList(aspects);
  set authorName(String authorName) => $unsafe['author_name'] = authorName;
  set authorUrl(String authorUrl) => $unsafe['author_url'] = authorUrl;
  set text(String text) => $unsafe['text'] = text;
}