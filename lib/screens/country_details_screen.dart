import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/view_models/country_details_vm.dart';
import 'package:country_info_app/widgets/country_info_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CountryDetailsScreen extends StatelessWidget {
  const CountryDetailsScreen({super.key, required this.country});

  final Country country;

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryDetailsVm>(
      builder: (ctx, model, child) => Scaffold(
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
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      model.updateIndex(index);
                    },
                  ),
                  items: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        country.flag,
                        // width: double.infinity,
                        // height: 200.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        country.coatOfArms,
                        //   width: double.infinity,
                        //   height: 200.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _placeholder("Image Not Available"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                AnimatedSmoothIndicator(
                  activeIndex: model.currentIndex,
                  count: 2,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                    dotColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 24),
                CountryInfoItem(
                    title: 'Population:',
                    info:
                        " ${NumberFormat('#,###').format(country.population)}"),
                const SizedBox(height: 4),
                CountryInfoItem(title: 'Region:', info: " ${country.region}"),
                const SizedBox(height: 4),
                CountryInfoItem(title: 'Capital:', info: " ${country.capital}"),
                const SizedBox(height: 4),
                CountryInfoItem(
                    title: 'Official Language:',
                    info: " ${country.languages.join(', ')}"),
                const SizedBox(height: 24),
                CountryInfoItem(
                    title: 'Independent:', info: " ${country.independent}"),
                const SizedBox(height: 4),
                CountryInfoItem(title: 'Area:', info: " ${country.area} km²"),
                const SizedBox(height: 4),
                CountryInfoItem(
                    title: 'Currency:', info: " ${country.currency}"),
                const SizedBox(height: 4),
                CountryInfoItem(
                    title: 'Time Zone:', info: " ${country.timeZone}"),
                const SizedBox(height: 24),
                CountryInfoItem(
                    title: 'Dialing Code:', info: " ${country.dialingCode}"),
                const SizedBox(height: 4),
                CountryInfoItem(
                    title: 'Driving Side:', info: " ${country.driverSide}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _placeholder(String text) {
  return Container(
    color: Colors.grey[300],
    width: double.infinity,
    height: 200,
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
