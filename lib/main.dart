import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'package:bike_ride/front%20end/authenticator/authenticator.dart';
import 'package:bike_ride/front%20end/screens/home/home_screen.dart';
import 'package:bike_ride/front%20end/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'front end/providers/backend_providers/current_user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> CurrentUserProvider())
    ],
    child: const BikeRideApp(),
  ));
}

class BikeRideApp extends StatelessWidget {
  const BikeRideApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'LexendPeta',
      ),
      home: const AuthenticatorWidget(
        welcomeScreen: WelcomeScreen(),
        homeScreen: HomeScreen(),
        debugModeLoggedIn: true,
      ),
    );
  }
}
