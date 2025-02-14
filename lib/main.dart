import 'package:country_info_app/screens/home_screen.dart';
import 'package:country_info_app/theme/theme_provider.dart';
import 'package:country_info_app/view_models/home_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (ctx) => ThemeProvider()),
        ChangeNotifierProvider<HomeScreenVm>(create: (ctx) => HomeScreenVm()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(428, 926),
      builder: (ctx, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: HomeScreen(),
      ),
    );
  }
}
