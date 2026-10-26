import 'dart:convert';
import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/screens/country_details_screen.dart';
import 'package:country_info_app/view_models/country_details_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeScreenVm extends ChangeNotifier {
  static const _pageSize = 100;
  static const _maxRequestAttempts = 3;
  static const _responseFields =
      'names.common,population,region,capitals.name,capitals.attributes.primary,'
      'languages.name,classification.sovereign,area.kilometers,currencies.code,'
      'timezones,calling_codes,cars.driving_side,flag.url_png,'
      'links.google_maps,links.open_street_maps';

  List<Country> _allCountries = [];
  List<Country> _filteredCountries = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<Country> get filteredCountries => _filteredCountries;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  HomeScreenVm() {
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final apiKey = dotenv.env['REST_COUNTRIES_API_KEY']?.trim() ?? '';
    if (apiKey.isEmpty) {
      _errorMessage =
          'Missing REST_COUNTRIES_API_KEY. Add your API key to the .env file.';
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final countries = <Country>[];
      var offset = 0;
      var total = 1;

      while (offset < total) {
        final url = Uri.https('api.restcountries.com', '/countries/v5', {
          'limit': '$_pageSize',
          'offset': '$offset',
          'response_fields': _responseFields,
        });
        final response = await _getCountryPage(url, apiKey);
        final decoded = jsonDecode(response.body);

        if (response.statusCode != 200) {
          throw FormatException(
            'Failed to load country data (HTTP ${response.statusCode}): '
            '${_apiErrorMessage(decoded)}',
          );
        }

        final page = _parseCountryPage(decoded);
        if (page.countries.isEmpty && offset < page.total) {
          throw const FormatException(
              'The countries API returned an empty page before the results ended.');
        }

        countries.addAll(page.countries);
        offset += page.countries.length;
        total = page.total;
      }

      _allCountries = countries;
      _filteredCountries = List.from(_allCountries);
    } catch (error) {
      _errorMessage = error is http.ClientException
          ? 'The connection to REST Countries was interrupted. Please try again.'
          : error.toString();
      debugPrint('Error fetching countries: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<http.Response> _getCountryPage(Uri url, String apiKey) async {
    var attempt = 0;
    while (true) {
      attempt++;
      try {
        final response = await http.get(
          url,
          headers: {'Authorization': 'Bearer $apiKey'},
        );

        final shouldRetry =
            response.statusCode == 429 || response.statusCode >= 500;
        if (!shouldRetry || attempt >= _maxRequestAttempts) {
          return response;
        }

        debugPrint(
          'Countries API returned HTTP ${response.statusCode}; '
          'retrying request ($attempt/$_maxRequestAttempts).',
        );
      } on http.ClientException catch (error) {
        if (attempt >= _maxRequestAttempts) {
          rethrow;
        }
        debugPrint(
          'Countries API request failed: $error; '
          'retrying ($attempt/$_maxRequestAttempts).',
        );
      }

      await Future<void>.delayed(Duration(seconds: attempt));
    }
  }

  _CountryPage _parseCountryPage(Object? response) {
    if (response is! Map<String, dynamic>) {
      throw const FormatException('The countries API returned invalid JSON.');
    }

    final data = response['data'];
    if (data is! Map<String, dynamic>) {
      throw FormatException(_apiErrorMessage(response));
    }

    final demo = data['_demo'];
    if (demo is Map<String, dynamic>) {
      final signupUrl = demo['signup_url'] as String?;
      throw FormatException(
        'The REST Countries demo key only returns sample data. '
        'Use a real API key${signupUrl == null ? '' : ' from $signupUrl'}.',
      );
    }

    final objects = data['objects'];
    final meta = data['meta'];
    if (objects is! List || meta is! Map<String, dynamic>) {
      throw FormatException(_apiErrorMessage(response));
    }

    final total = meta['total'];
    if (total is! num) {
      throw const FormatException(
          'The countries API response is missing its total count.');
    }

    return _CountryPage(
      countries: objects.map((json) {
        if (json is! Map<String, dynamic>) {
          throw const FormatException(
              'Country response contains an invalid item.');
        }
        return Country.fromJson(json);
      }).toList(),
      total: total.toInt(),
    );
  }

  String _apiErrorMessage(Object? response) {
    if (response is Map<String, dynamic>) {
      final errors = response['errors'];
      if (errors is List) {
        final messages = errors
            .map((error) =>
                error is Map<String, dynamic> ? error['message'] : error)
            .whereType<String>()
            .where((message) => message.isNotEmpty)
            .toList();
        if (messages.isNotEmpty) {
          return messages.join('; ');
        }
      }

      final message = response['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    return 'The countries API returned an unexpected response.';
  }

  void searchCountries(String query) {
    if (query.isEmpty) {
      fetchCountries();
      // _filteredCountries = List.from(_allCountries);
    } else {
      _filteredCountries = _allCountries
          .where((country) =>
              country.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void showDetails(BuildContext context, Country country) {
    Provider.of<CountryDetailsVm>(context, listen: false).resetIndex();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryDetailsScreen(country: country),
      ),
    ).then((_) {
      _filteredCountries = List.from(_allCountries);
      notifyListeners();
    });
  }
}

class _CountryPage {
  const _CountryPage({required this.countries, required this.total});

  final List<Country> countries;
  final int total;
}
