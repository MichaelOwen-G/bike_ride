import 'package:flutter/material.dart';

class AuthenticatorWidget extends StatefulWidget {
  final Widget welcomeScreen, homeScreen;
  const AuthenticatorWidget({required this.welcomeScreen, required this.homeScreen,super.key});

  @override
  State<AuthenticatorWidget> createState() => _AuthenticatorWidgetState();
}

class _AuthenticatorWidgetState extends State<AuthenticatorWidget> {
  @override
  Widget build(BuildContext context) {
    // check if logged in
    bool loggedIn = checkLoggedIn();

    return loggedIn ? widget.homeScreen // go to home screen
                    : widget.welcomeScreen; // go to welcome screen
  }

  bool checkLoggedIn(){
    return false;
  }
}
