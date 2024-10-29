import 'package:bike_ride/front%20end/authenticator/authenticator.dart';
import 'package:bike_ride/front%20end/screens/home/home_screen.dart';
import 'package:bike_ride/front%20end/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'LexendaPeta',
      ),
      home: const AuthenticatorWidget(welcomeScreen: WelcomeScreen(), homeScreen: HomeScreen()),
    );
  }
}
