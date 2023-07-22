import 'package:flutter/material.dart';
import 'package:task1/screens/UserDetails.dart';

import 'screens/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task',
      initialRoute: '/',
      theme: ThemeData(
        fontFamily: "SFPRO",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );

          case '/user-detail':
            final int? userId = settings.arguments as int?;
            return MaterialPageRoute(
              builder: (context) => UserDetails(userId: userId),
            );

          default:
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );
        }
      },
    );
  }
}
