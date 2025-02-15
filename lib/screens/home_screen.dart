import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/theme/theme_provider.dart';
import 'package:country_info_app/view_models/home_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Consumer<HomeScreenVm>(
      builder: (ctx, value, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            centerTitle: false,
            title: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Image.asset(
                  width: 98.w,
                  height: 24.h,
                  themeProvider.isDarkMode
                      ? 'assets/logo.png'
                      : "assets/ex_logo.png",
                );
              },
            ),
            actions: [
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return IconButton(
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                    icon: Icon(
                      themeProvider.isDarkMode
                          ? Icons.nightlight_outlined
                          : Icons.wb_sunny_outlined,
                    ),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: searchController,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: 'Search Country',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.tertiary,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  onChanged: (query) {
                    value.searchCountries(query);
                  },
                ),
                //  TODO ADD LANGUAGE AND FILTER
                // const SizedBox(height: 16),
                // Row(),
                const SizedBox(height: 16),
                Expanded(
                  child: value.filteredCountries.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : GroupedListView<Country, String>(
                          elements: value.filteredCountries,
                          groupBy: (country) => country.name[0].toUpperCase(),
                          groupSeparatorBuilder: (value) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                          itemBuilder: (ctx, country) {
                            return GestureDetector(
                              onTap: () {
                                value.showDetails(ctx, country);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        country.flag,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(Icons.broken_image,
                                              size: 40, color: Colors.grey);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          country.name,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          country.capital,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
