import 'dart:convert';
import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/screens/country_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenVm extends ChangeNotifier {
  final Uri url = Uri.parse("https://restcountries.com/v3.1/all");
  List<Country> _allCountries = [];
  List<Country> _filteredCountries = [];
  bool _isLoading = true;

  List<Country> get filteredCountries => _filteredCountries;
  bool get isLoading => _isLoading;

  HomeScreenVm() {
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      _allCountries = data.map((json) => Country.fromJson(json)).toList();
      _filteredCountries = List.from(_allCountries);
      notifyListeners();
    } else {
      throw Exception('Failed to load country data');
    }
  }

  void searchCountries(String query) {
    if (query.isEmpty) {
      _filteredCountries = List.from(_allCountries);
    } else {
      _filteredCountries = _allCountries
          .where((country) =>
              country.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void showDetails(BuildContext context, Country country) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryDetailsScreen(country: country),
      ),
    );
  }
}
