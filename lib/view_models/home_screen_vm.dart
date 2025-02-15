import 'dart:convert';
import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/screens/country_details_screen.dart';
import 'package:country_info_app/view_models/country_details_vm.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        _allCountries = data.map((json) => Country.fromJson(json)).toList();
        _filteredCountries = List.from(_allCountries);
        notifyListeners();
      } else {
        throw Exception('Failed to load country data');
      }
    } catch (e) {
      print("Error fetching countries: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
