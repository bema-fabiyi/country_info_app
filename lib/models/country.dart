class Country {
  final String name;
  final int population;
  final String region;
  final String capital;
  final String? motto;
  final List<String> languages;
  final List<String> ethnicGroups;
  final List<String> religions;
  final String government;
  final String independent;
  final double area;
  final String currency;
  final String gdp;
  final String timeZone;
  final String dateFormat;
  final String dialingCode;
  final String driverSide;
  final String flag;

  Country({
    required this.name,
    required this.population,
    required this.region,
    required this.capital,
    this.motto,
    required this.languages,
    required this.ethnicGroups,
    required this.religions,
    required this.government,
    required this.independent,
    required this.area,
    required this.currency,
    required this.gdp,
    required this.timeZone,
    required this.dateFormat,
    required this.dialingCode,
    required this.driverSide,
    required this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? 'Unknown',
      population: json['population'] ?? 0,
      region: json['region'] ?? 'Unknown',
      capital: (json['capital'] as List?)?.first ?? 'Unknown',
      motto: json[''],
      languages: (json['languages'] as Map?)
              ?.values
              .map((e) => e.toString())
              .toList() ??
          [],
      ethnicGroups: json['ethnicGroups'] != null
          ? List<String>.from(json['ethnicGroups'])
          : [],
      religions:
          json['religions'] != null ? List<String>.from(json['religions']) : [],
      government: json['government'] ?? 'Unknown',
      independent: json['independent'] != null
          ? (json['independent'] ? 'Yes' : 'No')
          : 'Unknown',
      area: json['area']?.toDouble() ?? 0.0,
      currency: json['currencies'] != null
          ? json['currencies'].keys.first
          : 'Unknown',
      gdp: json['gdp']?.toString() ?? 'Unknown',
      timeZone: (json['timezones'] as List?)?.first ?? 'Unknown',
      dateFormat: json['dateFormat'] ?? 'Unknown',
      dialingCode: (json['idd']?['root'] ?? '') +
          (json['idd']?['suffixes']?.first ?? ''),
      driverSide: json['car']?['side'] ?? 'Unknown',
      flag: json['flags']?['png'] ?? '',
    );
  }
}

// class CountryListScreen extends StatefulWidget {
//   @override
//   _CountryListScreenState createState() => _CountryListScreenState();
// }

// class _CountryListScreenState extends State<CountryListScreen> {
//   late Future<List<Country>> futureCountries;

//   @override
//   void initState() {
//     super.initState();
//     futureCountries = fetchCountries();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Country Information')),
//       body: FutureBuilder<List<Country>>(
//         future: futureCountries,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No data available'));
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final country = snapshot.data![index];
//               return ListTile(
//                 leading: Image.network(country.flag, width: 50, height: 30),
//                 title: Text(country.name),
//                 subtitle: Text('${country.region} - ${country.capital}'),
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: Text(country.name),
//                       content: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text('Population: ${country.population}'),
//                           Text('Capital: ${country.capital}'),
//                           Text('Region: ${country.region}'),
//                           Text('Independence: ${country.independence}'),
//                           Text('Currency: ${country.currency}'),
//                           Text('Time Zone: ${country.timeZone}'),
//                           Text('Driver Side: ${country.driverSide}'),
//                         ],
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: Text('Close'),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
