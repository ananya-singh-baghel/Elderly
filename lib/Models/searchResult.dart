// To parse this JSON data, do
//
//     final searchResult = searchResultFromJson(jsonString);

import 'dart:convert';

SearchResult searchResultFromJson(String str) =>
    SearchResult.fromJson(json.decode(str));

String searchResultToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
  SearchResult({
    this.htmlAttributions,
    this.nextPageToken,
    this.results,
    this.status,
  });

  List<dynamic>? htmlAttributions;
  String? nextPageToken;
  List<Result>? results;
  String? status;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        htmlAttributions:
            List<dynamic>.from(json["html_attributions"].map((x) => x)),
        nextPageToken: json["next_page_token"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions":
            List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "next_page_token": nextPageToken,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "status": status,
      };
}

class Result {
  Result({
    this.businessStatus,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.types,
    this.userRatingsTotal,
  });

  BusinessStatus? businessStatus;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  IconBackgroundColor? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  OpeningHours? openingHours;
  List<Photo>? photos;
  String? placeId;
  PlusCode? plusCode;
  double? rating;
  String? reference;
  List<Type>? types;
  int? userRatingsTotal;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        businessStatus: businessStatusValues.map[json["business_status"]],
        formattedAddress: json["formatted_address"],
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor:
            iconBackgroundColorValues.map[json["icon_background_color"]],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        name: json["name"],
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        photos: json["photos"] == null
            ? null
            : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        placeId: json["place_id"],
        plusCode: json["plus_code"] == null
            ? null
            : PlusCode.fromJson(json["plus_code"]),
        rating: json["rating"].toDouble(),
        reference: json["reference"],
        types: [Type.HEALTH],
        userRatingsTotal: json["user_ratings_total"],
      );

  Map<String, dynamic> toJson() => {
        "business_status": businessStatusValues.reverse[businessStatus],
        "formatted_address": formattedAddress,
        "geometry": geometry!.toJson(),
        "icon": icon,
        "icon_background_color":
            iconBackgroundColorValues.reverse[iconBackgroundColor],
        "icon_mask_base_uri": iconMaskBaseUri,
        "name": name,
        "opening_hours": openingHours == null ? null : openingHours!.toJson(),
        "photos": photos == null
            ? null
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "place_id": placeId,
        "plus_code": plusCode == null ? null : plusCode!.toJson(),
        "rating": rating,
        "reference": reference,
        "types": List<dynamic>.from(types!.map((x) => typeValues.reverse[x])),
        "user_ratings_total": userRatingsTotal,
      };
}

enum BusinessStatus { OPERATIONAL }

final businessStatusValues =
    EnumValues({"OPERATIONAL": BusinessStatus.OPERATIONAL});

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Location? location;
  Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location!.toJson(),
        "viewport": viewport!.toJson(),
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location? northeast;
  Location? southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast!.toJson(),
        "southwest": southwest!.toJson(),
      };
}

enum IconBackgroundColor { THE_7_B9_EB0 }

final iconBackgroundColorValues =
    EnumValues({"#7B9EB0": IconBackgroundColor.THE_7_B9_EB0});

class OpeningHours {
  OpeningHours({
    this.openNow,
  });

  bool? openNow;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
      };
}

class Photo {
  Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions:
            List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions":
            List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
      };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String? compoundCode;
  String? globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}

enum Type { POINT_OF_INTEREST, HEALTH, ESTABLISHMENT, PHYSIOTHERAPIST, DOCTOR }

final typeValues = EnumValues({
  "doctor": Type.DOCTOR,
  "establishment": Type.ESTABLISHMENT,
  "health": Type.HEALTH,
  "physiotherapist": Type.PHYSIOTHERAPIST,
  "point_of_interest": Type.POINT_OF_INTEREST
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
