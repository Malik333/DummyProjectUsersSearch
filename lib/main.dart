import 'package:flutter/material.dart';
import 'package:dummy_project_users_search/routes/route_generator.dart';
import 'package:dummy_project_users_search/ui/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: RouteGenerator().generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
        ),
      ),
      initialRoute: SplashScreen.route,
      debugShowCheckedModeBanner: false,
    );
  }
}
