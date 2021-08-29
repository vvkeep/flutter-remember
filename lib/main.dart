import 'package:flutter/material.dart';
import 'package:remember/config/style.dart';
import 'package:remember/router/application.dart';
import 'package:remember/router/route_handles.dart';

void main() {
  Routes.configureRoutes(Application.router);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: RMColors.primaryColor),
      onGenerateRoute: (routeSettings) =>
          Application.router.generator(routeSettings),
    );
  }
}
