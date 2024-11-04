import 'package:bike_ride/front%20end/drawables/bike_ride_logo/bike_ride_logo.dart';
import 'package:bike_ride/front%20end/drawables/gradient_background.dart';
import 'package:bike_ride/front%20end/values/images.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void _quickRegister() {
    // create quick account

    // change loggedIn status
  }

  void _createAccount() {}

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
          child:

              // * body
              Container(
        height: maxHeight,
        width: maxWidth,
        decoration: _backgroundDecor(),
        child: MyGradientBackground(
            child: Column(children: [
              // bike ride logo
              const Expanded(child: BikeRideLogo()),

              // information
              Expanded(flex: 7, child: _bikeRideInfo()),

              // find bike button
              Expanded(
                  flex: 3,
                  child:
                        _findBikeBtn()),
            ])),
      )),
    );
  }

  // * background decoration
  BoxDecoration _backgroundDecor() {
    return BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fitHeight,
            opacity: .5,
            image: AssetImage(welcomeBackgroundImage)));
  }

  Widget _bikeRideInfo() {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 44),
      child: const SizedBox(
        width: 220,
        child: Text('Bike Rental Services around Juja',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: 'LexendPeta',
            )),
      ),
    );
  }

  Widget _findBikeBtn() {
    return Container(
        alignment: Alignment.center,
        child: FilledButton(
            onPressed: _quickRegister,
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)))),
            child: const Text('Find Bike')));
  }

  Widget _createAccountBtn() {
    return Container(
        alignment: Alignment.center,
        child: FilledButton(
            onPressed: _createAccount,
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)))),
            child: const Text('Create Account')));
  }
}
