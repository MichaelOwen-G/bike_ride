import 'package:bike_ride/back%20end/services/rentals_services.dart';
import 'package:bike_ride/front%20end/drawables/bike_ride_logo/bike_ride_logo.dart';
import 'package:bike_ride/front%20end/drawables/cyclist_account_logo/cyclist_account_logo.dart';
import 'package:bike_ride/front%20end/drawables/masked_content_animation/masked_content_animation.dart';
import 'package:bike_ride/front%20end/drawables/sort_button_bar/sort_button_bar.dart';
import 'package:bike_ride/front%20end/functionalities/login_functionality/login_functionality.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../back end/models/rental.dart';
import '../../../back end/models/user.dart';
import '../../drawables/gradient_background/gradient_background.dart';
import '../../providers/backend_providers/current_user_provider.dart';
import '../../values/colors.dart';

part 'home_app_bar.dart';
part 'home_content_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with LoginFunctionality {
  @override
  Widget build(BuildContext context) {

    // declare a CurrentUserProvider object
    CurrentUserProvider userProvider = Provider.of<CurrentUserProvider>(context, listen: false);

    // fetch user info
      fetchUser().then((User? user){
      // update the CurrentUserProvider value
      userProvider.user = user;
    });

    return Scaffold(
        backgroundColor: silver.withAlpha(240),
        body: const SafeArea(
          child:
              // gradient background
              MyGradientBackground(
            child:

                // body
                Column(children: [
              // app bar
              Expanded(child: HomeAppBar()),

              // body
              Expanded(
                  flex: 5,
                  child: HomeContentWidget())
            ]),
          ),
        ));
  }

  }


