class Country {
  final String name;
  final int population;
  final String region;
  final String capital;
  final List<String> languages;
  final Maps map;
  final String independent;
  final double area;
  final String currency;
  final String timeZone;
  final String dialingCode;
  final String driverSide;
  final String flag;

  Country({
    required this.name,
    required this.population,
    required this.region,
    required this.capital,
    required this.languages,
    required this.independent,
    required this.area,
    required this.currency,
    required this.timeZone,
    required this.dialingCode,
    required this.driverSide,
    required this.flag,
    required this.map,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final names = _jsonObject(json['names']);
    final capitals =
        _jsonList(json['capitals']).whereType<Map<String, dynamic>>().toList();
    String? capital;
    for (final candidate in capitals) {
      if (_jsonObject(candidate['attributes'])['primary'] == true) {
        capital = candidate['name'] as String?;
        break;
      }
    }
    capital ??= capitals.isNotEmpty ? capitals.first['name'] as String? : null;
    final currencies = _jsonList(json['currencies'])
        .whereType<Map<String, dynamic>>()
        .toList();
    final languages = _jsonList(json['languages'])
        .whereType<Map<String, dynamic>>()
        .map((language) => language['name'])
        .whereType<String>()
        .toList();
    final callingCodes = _jsonList(json['calling_codes'])
        .whereType<String>()
        .map((code) => '+$code')
        .toList();
    final timeZones = _jsonList(json['timezones']).whereType<String>();
    final area = _jsonObject(json['area'])['kilometers'];
    final classification = _jsonObject(json['classification']);
    final cars = _jsonObject(json['cars']);
    final flag = _jsonObject(json['flag']);
    final links = _jsonObject(json['links']);

    return Country(
      name: names['common'] as String? ?? 'Unknown',
      population: (json['population'] as num?)?.toInt() ?? 0,
      region: json['region'] as String? ?? 'Unknown',
      capital: capital ?? 'Unknown',
      languages: languages,
      independent: classification['sovereign'] is bool
          ? (classification['sovereign'] as bool ? 'Yes' : 'No')
          : 'Unknown',
      area: (area as num?)?.toDouble() ?? 0.0,
      currency: currencies.isNotEmpty
          ? currencies.first['code'] as String? ?? 'Unknown'
          : 'Unknown',
      timeZone: timeZones.isNotEmpty ? timeZones.first : 'Unknown',
      dialingCode:
          callingCodes.isNotEmpty ? callingCodes.join(', ') : 'Unknown',
      driverSide: cars['driving_side'] as String? ?? 'Unknown',
      flag: flag['url_png'] as String? ?? '',
      map: Maps.fromJson(links),
    );
  }
}

Map<String, dynamic> _jsonObject(Object? value) =>
    value is Map<String, dynamic> ? value : const {};

List<dynamic> _jsonList(Object? value) => value is List ? value : const [];

class Maps {
  String googleMaps;
  String openStreetMaps;

  Maps({
    required this.googleMaps,
    required this.openStreetMaps,
  });

  factory Maps.fromJson(Map<String, dynamic> json) => Maps(
        googleMaps: json["google_maps"] as String? ?? '',
        openStreetMaps: json["open_street_maps"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "google_maps": googleMaps,
        "open_street_maps": openStreetMaps,
      };
}
