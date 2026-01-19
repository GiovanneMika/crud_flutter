import 'package:crud_flutter/views/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      initialRoute: '/home',
      routes: {'/home': (context) => HomePage()},
    );
  }
}
