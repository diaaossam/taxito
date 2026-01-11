class SuggestionModel {
  SuggestionModel({
      this.name, 
      this.namePreferred, 
      this.mapboxId, 
      this.featureType, 
      this.placeFormatted, 
      this.context, 
      this.language, 
      this.maki, 
      this.metadata,});

  SuggestionModel.fromJson(dynamic json) {
    name = json['name'];
    namePreferred = json['name_preferred'];
    mapboxId = json['mapbox_id'];
    featureType = json['feature_type'];
    placeFormatted = json['place_formatted'];
    context = json['context'] != null ? Context.fromJson(json['context']) : null;
    language = json['language'];
    maki = json['maki'];
    metadata = json['metadata'];
  }
  String? name;
  String? namePreferred;
  String? mapboxId;
  String? featureType;
  String? placeFormatted;
  Context? context;
  String? language;
  String? maki;
  dynamic metadata;
SuggestionModel copyWith({  String? name,
  String? namePreferred,
  String? mapboxId,
  String? featureType,
  String? placeFormatted,
  Context? context,
  String? language,
  String? maki,
  dynamic metadata,
}) => SuggestionModel(  name: name ?? this.name,
  namePreferred: namePreferred ?? this.namePreferred,
  mapboxId: mapboxId ?? this.mapboxId,
  featureType: featureType ?? this.featureType,
  placeFormatted: placeFormatted ?? this.placeFormatted,
  context: context ?? this.context,
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
    map['place_formatted'] = placeFormatted;
    if (context != null) {
      map['context'] = context?.toJson();
    }
    map['language'] = language;
    map['maki'] = maki;
    map['metadata'] = metadata;
    return map;
  }

}

class Context {
  Context({
      this.country,});

  Context.fromJson(dynamic json) {
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }
  Country? country;
Context copyWith({  Country? country,
}) => Context(  country: country ?? this.country,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (country != null) {
      map['country'] = country?.toJson();
    }
    return map;
  }

}

class Country {
  Country({
      this.id, 
      this.name, 
      this.countryCode, 
      this.countryCodeAlpha3,});

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
Country copyWith({  String? id,
  String? name,
  String? countryCode,
  String? countryCodeAlpha3,
}) => Country(  id: id ?? this.id,
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