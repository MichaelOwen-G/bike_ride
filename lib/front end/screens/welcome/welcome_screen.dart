import 'package:bike_ride/front%20end/values/images.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  void _quickRegister(){
    // create quick account

    // change loggedIn status
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child:

              // * body
              Container(
        height: maxHeight,
        width: maxWidth,
        decoration: _backgroundDecor(),
        child: Container(
            padding: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const <double>[
                  .7,
                  1,
                ],
                    colors: <Color>[
                  Colors.black.withAlpha(140),
                  Colors.black12,
                ])),
            child: Column(
              children: [
                // bike ride logo
                Expanded(child: _bikeRideLogo()),

                // information
                Expanded(flex: 5, child: _bikeRideInfo()),

                // find bike button
                Expanded(flex: 2, child: _findBikeBtn()),
              ],
            )),
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

  // * bike ride logo
  Widget _bikeRideLogo() {
    return Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 18),
        child: RichText(
              text: const TextSpan(style: TextStyle(fontSize: 20), children: [
            TextSpan(
              text: 'Bike ',
              style: TextStyle(color: Colors.white),
            ),
            TextSpan(
              text: 'Ride',
              style: TextStyle(color: Colors.black),
            )
          ])),
        );
  }

  Widget _bikeRideInfo() {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 44, right: 32),
      child: const SizedBox(
        width: 160,
        child: Text('Bike Rental Services around Juja',
            style: TextStyle(color: Colors.white, fontSize: 34)),
      ),
    );
  }

  Widget _findBikeBtn() {
    return Container(
        alignment: Alignment.center,
        child: FilledButton(
            onPressed: _quickRegister,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)))),
            child: const Text('Find Bike')));
  }
}
