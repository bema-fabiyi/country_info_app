import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/widgets/country_info_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CountryDetailsScreen extends StatelessWidget {
  const CountryDetailsScreen({super.key, required this.country});

  final Country country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          country.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  country.flag,
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 24),
              CountryInfoItem(
                  title: 'Population:',
                  info: " ${NumberFormat('#,###').format(country.population)}"),
              const SizedBox(height: 4),
              CountryInfoItem(title: 'Region:', info: " ${country.region}"),
              const SizedBox(height: 4),
              CountryInfoItem(title: 'Capital:', info: " ${country.capital}"),
              const SizedBox(height: 4),
              CountryInfoItem(
                title: 'Motto:',
                info: " ${country.motto}",
              ),
              const SizedBox(height: 24),
              CountryInfoItem(
                  title: 'Official Language:',
                  info: " ${country.languages.join(', ')}"),
              const SizedBox(height: 4),
              CountryInfoItem(
                  title: 'Ethnic Group:',
                  info: " ${country.ethnicGroups.join(', ')}"),
              const SizedBox(height: 4),
              CountryInfoItem(
                  title: 'Religion:', info: " ${country.religions.join(', ')}"),
              const SizedBox(height: 4),
              CountryInfoItem(
                  title: 'Government:', info: " ${country.government}"),
              const SizedBox(height: 24),
              CountryInfoItem(
                  title: 'Independence:', info: " ${country.independent}"),
              const SizedBox(height: 4),
              CountryInfoItem(title: 'Area:', info: " ${country.area} km²"),
              const SizedBox(height: 4),
              CountryInfoItem(title: 'Currency:', info: " ${country.currency}"),
              const SizedBox(height: 4),
              CountryInfoItem(title: 'GDP:', info: " ${country.gdp}"),
              const SizedBox(height: 24),
              CountryInfoItem(
                  title: 'Time Zone:', info: " ${country.timeZone}"),
              const SizedBox(height: 4),
              CountryInfoItem(
                  title: 'Date Format:', info: " ${country.dateFormat}"),
              const SizedBox(height: 4),
              CountryInfoItem(
                  title: 'Dialing Code:', info: " ${country.dialingCode}"),
              const SizedBox(height: 4),
              CountryInfoItem(
                  title: 'Driving Side:', info: " ${country.driverSide}"),
            ],
          ),
        ),
      ),
    );
  }
}
