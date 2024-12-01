import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticatorWidget extends StatefulWidget {
  final Widget welcomeScreen, homeScreen;
  final bool? debugModeLoggedIn;
  const AuthenticatorWidget(
      {required this.welcomeScreen,
      required this.homeScreen,
      this.debugModeLoggedIn,
      super.key});

  @override
  State<AuthenticatorWidget> createState() => _AuthenticatorWidgetState();
}

class _AuthenticatorWidgetState extends State<AuthenticatorWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          User? user = snapshot.data;
          return widget.debugModeLoggedIn != null
              ? user == null
                  ? // go to welcome screen
                  widget.welcomeScreen
                  : // go to home screen
                  widget.homeScreen
              : widget.debugModeLoggedIn!
                  ? widget.homeScreen
                  : widget.welcomeScreen;
        });
  }
}
