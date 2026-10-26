import 'package:country_info_app/models/country.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps REST Countries v5 fields into a country', () {
    final country = Country.fromJson({
      'names': {'common': 'Canada'},
      'population': 41798407,
      'region': 'Americas',
      'capitals': [
        {
          'name': 'Ottawa',
          'attributes': {'primary': true},
        },
      ],
      'languages': [
        {'name': 'English'},
        {'name': 'French'},
      ],
      'classification': {'sovereign': true},
      'area': {'kilometers': 9984670},
      'currencies': [
        {'code': 'CAD'},
      ],
      'timezones': ['UTC-08:00', 'UTC-07:00'],
      'calling_codes': ['1'],
      'cars': {'driving_side': 'right'},
      'flag': {'url_png': 'https://example.com/canada.png'},
      'links': {
        'google_maps': 'https://maps.example.com/canada',
        'open_street_maps': 'https://osm.example.com/canada',
      },
    });

    expect(country.name, 'Canada');
    expect(country.population, 41798407);
    expect(country.region, 'Americas');
    expect(country.capital, 'Ottawa');
    expect(country.languages, ['English', 'French']);
    expect(country.independent, 'Yes');
    expect(country.area, 9984670);
    expect(country.currency, 'CAD');
    expect(country.timeZone, 'UTC-08:00');
    expect(country.dialingCode, '+1');
    expect(country.driverSide, 'right');
    expect(country.flag, 'https://example.com/canada.png');
    expect(country.map.googleMaps, 'https://maps.example.com/canada');
    expect(country.map.openStreetMaps, 'https://osm.example.com/canada');
  });

  test('uses fallback values when optional v5 fields are missing', () {
    final country = Country.fromJson({
      'names': {'common': 'Unknownia'},
    });

    expect(country.name, 'Unknownia');
    expect(country.capital, 'Unknown');
    expect(country.languages, isEmpty);
    expect(country.independent, 'Unknown');
    expect(country.area, 0);
    expect(country.currency, 'Unknown');
    expect(country.timeZone, 'Unknown');
    expect(country.dialingCode, 'Unknown');
    expect(country.driverSide, 'Unknown');
    expect(country.flag, isEmpty);
  });
}
