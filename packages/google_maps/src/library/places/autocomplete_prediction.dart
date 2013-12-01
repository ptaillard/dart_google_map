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

class AutocompletePrediction extends jsw.TypedProxy {
  static AutocompletePrediction cast(js.Proxy proxy) => proxy == null ? null : new AutocompletePrediction.fromProxy(proxy);

  AutocompletePrediction() : super();
  AutocompletePrediction.fromProxy(js.Proxy proxy) : super.fromProxy(proxy);

  String get description => $unsafe['description'];
  String get id => $unsafe['id'];
  List<PredictionSubstring> get matchedSubstrings => jsw.JsArrayToListAdapter.castListOfSerializables($unsafe['matched_substrings'], PredictionSubstring.cast);
  String get reference => $unsafe['reference'];
  List<PredictionTerm> get terms => jsw.JsArrayToListAdapter.castListOfSerializables($unsafe['terms'], PredictionTerm.cast);
  List<String> get types => jsw.JsArrayToListAdapter.cast($unsafe['types']);
  set description(String description) => $unsafe['description'] = description;
  set id(String id) => $unsafe['id'] = id;
  set matchedSubstrings(List<PredictionSubstring> matchedSubstrings) => $unsafe['matched_substrings'] = jsifyList(matchedSubstrings);
  set reference(String reference) => $unsafe['reference'] = reference;
  set terms(List<PredictionTerm> terms) => $unsafe['terms'] = jsifyList(terms);
  set types(List<String> types) => $unsafe['types'] = jsifyList(types);
}