class Country {
  final String name;
  final int population;
  final String region;
  final String capital;
  final List<String> languages;
  final Maps map;
  final String coatOfArms;
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
    required this.coatOfArms,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? 'Unknown',
      population: json['population'] ?? 0,
      region: json['region'] ?? 'Unknown',
      capital: (json['capital'] as List?)?.first ?? 'Unknown',
      languages: (json['languages'] as Map?)
              ?.values
              .map((e) => e.toString())
              .toList() ??
          [],
      independent: json['independent'] != null
          ? (json['independent'] ? 'Yes' : 'No')
          : 'Unknown',
      area: json['area']?.toDouble() ?? 0.0,
      currency: json['currencies'] != null
          ? json['currencies'].keys.first
          : 'Unknown',
      timeZone: (json['timezones'] as List?)?.first ?? 'Unknown',
      dialingCode: (json['idd']?['root'] ?? '') +
          (json['idd']?['suffixes']?.first ?? ''),
      driverSide: json['car']?['side'] ?? 'Unknown',
      flag: json['flags']?['png'] ?? '',
      coatOfArms: json['coatOfArms']?['png'] ?? 'No Coat Of Arm',
      map: Maps.fromJson(json["maps"]),
    );
  }
}

class Maps {
  String googleMaps;
  String openStreetMaps;

  Maps({
    required this.googleMaps,
    required this.openStreetMaps,
  });

  factory Maps.fromJson(Map<String, dynamic> json) => Maps(
        googleMaps: json["googleMaps"],
        openStreetMaps: json["openStreetMaps"],
      );

  Map<String, dynamic> toJson() => {
        "googleMaps": googleMaps,
        "openStreetMaps": openStreetMaps,
      };
}
