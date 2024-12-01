import 'package:bike_ride/front%20end/functionalities/login_functionality/login_functionality.dart';
import 'package:flutter/material.dart';

import '../../../back end/models/user.dart';

class LoginDialog extends StatefulWidget {

  const LoginDialog({ super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> with LoginFunctionality{
  List<LoginStyle> loginStyles = [];

  @override
  void initState() {
    super.initState();

    loginStyles = [

      LoginStyle(
          title: "Register",
          icon: Icons.account_box_outlined,
          points: [
            '•Add email', '•Secure with password',
            '•Log in from anywhere',
            '•Enjoy more functionality',
          ],
          onPressed: _toRegisterAccount,
          addSignInBtn: true,
          signInFunc: _toSignInToAccount
      ),

      LoginStyle(
        title: "Quick Login",
        icon: Icons.run_circle_outlined,
        points: [
          '•No email', '•No setting passwords', '•Guest mode',
          '•Add account details later',
        ],
        onPressed: _quickRegister,
      ),
    ];
  }

    Future<LoginErrors> _quickRegister() async {

    // create quick account
    Map userAndError = await createAccount(accountType: AccountType.ANONYMOUS);

    return userAndError['error'];
  }

  void _toRegisterAccount() async {
    // navigate to create account page
  }

  void _toSignInToAccount(){
    // navigate to sing in to account page
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            elevation: 0,
            child: Container(

              width: screenWidth,
              height: screenHeight,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: AnimatedOpacity(opacity: 1, duration: const Duration(milliseconds: 1000), child: ListView(
                  padding: const EdgeInsets.only(top: 30),
                  children: loginStyles
                      .map((e) => LoginStyleWidget(loginStyle: e))
                      .toList()),
            ))));
  }
}

class LoginStyleWidget extends StatefulWidget {
  final LoginStyle loginStyle;

  const LoginStyleWidget({required this.loginStyle, super.key});

  @override
  State<LoginStyleWidget> createState() => _LoginStyleWidgetState();
}

class _LoginStyleWidgetState extends State<LoginStyleWidget> {
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: _$decoration(),
      padding: const EdgeInsets.only(top: 20),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            // login style icon
            _icon(widget.loginStyle),

            const SizedBox(height: 10),

            // login style name
            _name(widget.loginStyle),

            const SizedBox(height: 25),

            // login style points
            _points(widget.loginStyle),

            const SizedBox(height: 25),

            // login style button
            _logInButton(widget.loginStyle),

            // sign in button if possible
            SizedBox(
                child: widget.loginStyle.addSignInBtn
                    ? _signInBtn(widget.loginStyle)
                    : null),
          ]),
    );
  }

  Widget _icon(LoginStyle style) {
    return Container(
        alignment: Alignment.center,
        child: Icon(style.icon, size: 56, color: Colors.black));
  }

  Widget _name(LoginStyle style) {
    return Container(
      alignment: Alignment.center,
      child: Text(style.title,
          style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _points(LoginStyle style) {
    return Container(
      alignment: Alignment.center,
      child: Container(
          width: 250,
          padding: const EdgeInsets.only(left: 20, right: 5),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: style.points
                  .map((e) => SizedBox(
                      width: double.infinity,
                      child: Text(
                        e,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 10),
                      )))
                  .toList())),
    );
  }

  Widget _logInButton(LoginStyle style) {
    return GestureDetector(
        onTap: () => style.onPressed(),
        child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5))),
          child: Text(
            style.title,
            style: const TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget _signInBtn(LoginStyle style) {
    return GestureDetector(
        onTap: () => style.signInFunc!(),
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5))),
          child: const Text(
            'SIGN IN',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  BoxDecoration _$decoration() {
    return BoxDecoration(
      color: Colors.white.withAlpha(220),
      borderRadius: BorderRadius.circular(5),
      boxShadow: kElevationToShadow[2],
    );
  }
}

class LoginStyle {
  String title;
  IconData icon;
  List<String> points;
  Function onPressed;
  final bool addSignInBtn;
  final Function? signInFunc;

  LoginStyle({
    required this.title,
    required this.icon,
    required this.points,
    required this.onPressed,
    this.addSignInBtn = false,
    this.signInFunc,
  });
}
