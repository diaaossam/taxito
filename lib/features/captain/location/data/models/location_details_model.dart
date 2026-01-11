class LocationDetailsModel {
  LocationDetailsModel({
    this.type,
    this.geometry,
    this.properties,
  });

  LocationDetailsModel.fromJson(dynamic json) {
    type = json['type'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
  }

  String? type;
  Geometry? geometry;
  Properties? properties;

  LocationDetailsModel copyWith({
    String? type,
    Geometry? geometry,
    Properties? properties,
  }) =>
      LocationDetailsModel(
        type: type ?? this.type,
        geometry: geometry ?? this.geometry,
        properties: properties ?? this.properties,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    if (properties != null) {
      map['properties'] = properties?.toJson();
    }
    return map;
  }
}

class Properties {
  Properties({
    this.name,
    this.namePreferred,
    this.mapboxId,
    this.featureType,
    this.fullAddress,
    this.placeFormatted,
    this.context,
    this.coordinates,
    this.language,
    this.maki,
    this.metadata,
  });

  Properties.fromJson(dynamic json) {
    name = json['name'];
    namePreferred = json['name_preferred'];
    mapboxId = json['mapbox_id'];
    featureType = json['feature_type'];
    fullAddress = json['full_address'];
    placeFormatted = json['place_formatted'];
    context =
        json['context'] != null ? Context.fromJson(json['context']) : null;
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
    language = json['language'];
    maki = json['maki'];
    metadata = json['metadata'];
  }

  String? name;
  String? namePreferred;
  String? mapboxId;
  String? featureType;
  String? fullAddress;
  String? placeFormatted;
  Context? context;
  Coordinates? coordinates;
  String? language;
  String? maki;
  dynamic metadata;

  Properties copyWith({
    String? name,
    String? namePreferred,
    String? mapboxId,
    String? featureType,
    String? fullAddress,
    String? placeFormatted,
    Context? context,
    Coordinates? coordinates,
    String? language,
    String? maki,
    dynamic metadata,
  }) =>
      Properties(
        name: name ?? this.name,
        namePreferred: namePreferred ?? this.namePreferred,
        mapboxId: mapboxId ?? this.mapboxId,
        featureType: featureType ?? this.featureType,
        fullAddress: fullAddress ?? this.fullAddress,
        placeFormatted: placeFormatted ?? this.placeFormatted,
        context: context ?? this.context,
        coordinates: coordinates ?? this.coordinates,
        language: language ?? this.language,
        maki: maki ?? this.maki,
        metadata: metadata ?? this.metadata,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['name_preferred'] = namePreferred;
    map['mapbox_id'] = mapboxId;
    map['feature_type'] = featureType;
    map['full_address'] = fullAddress;
    map['place_formatted'] = placeFormatted;
    if (context != null) {
      map['context'] = context?.toJson();
    }
    if (coordinates != null) {
      map['coordinates'] = coordinates?.toJson();
    }
    map['language'] = language;
    map['maki'] = maki;
    map['metadata'] = metadata;
    return map;
  }
}

class Coordinates {
  Coordinates({
    this.latitude,
    this.longitude,
  });

  Coordinates.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  num? latitude;
  num? longitude;

  Coordinates copyWith({
    num? latitude,
    num? longitude,
  }) =>
      Coordinates(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }
}

class Context {
  Context({
    this.country,
    this.region,
    this.place,
    this.locality,
  });

  Context.fromJson(dynamic json) {
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
    locality =
        json['locality'] != null ? Locality.fromJson(json['locality']) : null;
  }

  Country? country;
  Region? region;
  Place? place;
  Locality? locality;

  Context copyWith({
    Country? country,
    Region? region,
    Place? place,
    Locality? locality,
  }) =>
      Context(
        country: country ?? this.country,
        region: region ?? this.region,
        place: place ?? this.place,
        locality: locality ?? this.locality,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (country != null) {
      map['country'] = country?.toJson();
    }
    if (region != null) {
      map['region'] = region?.toJson();
    }
    if (place != null) {
      map['place'] = place?.toJson();
    }
    if (locality != null) {
      map['locality'] = locality?.toJson();
    }
    return map;
  }
}

class Locality {
  Locality({
    this.id,
    this.name,
  });

  Locality.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  String? id;
  String? name;

  Locality copyWith({
    String? id,
    String? name,
  }) =>
      Locality(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class Place {
  Place({
    this.id,
    this.name,
  });

  Place.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  String? id;
  String? name;

  Place copyWith({
    String? id,
    String? name,
  }) =>
      Place(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class Region {
  Region({
    this.id,
    this.name,
    this.regionCode,
    this.regionCodeFull,
  });

  Region.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    regionCode = json['region_code'];
    regionCodeFull = json['region_code_full'];
  }

  String? id;
  String? name;
  String? regionCode;
  String? regionCodeFull;

  Region copyWith({
    String? id,
    String? name,
    String? regionCode,
    String? regionCodeFull,
  }) =>
      Region(
        id: id ?? this.id,
        name: name ?? this.name,
        regionCode: regionCode ?? this.regionCode,
        regionCodeFull: regionCodeFull ?? this.regionCodeFull,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['region_code'] = regionCode;
    map['region_code_full'] = regionCodeFull;
    return map;
  }
}

class Country {
  Country({
    this.id,
    this.name,
    this.countryCode,
    this.countryCodeAlpha3,
  });

  Country.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    countryCodeAlpha3 = json['country_code_alpha_3'];
  }

  String? id;
  String? name;
  String? countryCode;
  String? countryCodeAlpha3;

  Country copyWith({
    String? id,
    String? name,
    String? countryCode,
    String? countryCodeAlpha3,
  }) =>
      Country(
        id: id ?? this.id,
        name: name ?? this.name,
        countryCode: countryCode ?? this.countryCode,
        countryCodeAlpha3: countryCodeAlpha3 ?? this.countryCodeAlpha3,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['country_code'] = countryCode;
    map['country_code_alpha_3'] = countryCodeAlpha3;
    return map;
  }
}

class Geometry {
  Geometry({
    this.coordinates,
    this.type,
  });

  Geometry.fromJson(dynamic json) {
    coordinates =
        json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
    type = json['type'];
  }

  List<num>? coordinates;
  String? type;

  Geometry copyWith({
    List<num>? coordinates,
    String? type,
  }) =>
      Geometry(
        coordinates: coordinates ?? this.coordinates,
        type: type ?? this.type,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    map['type'] = type;
    return map;
  }
}
