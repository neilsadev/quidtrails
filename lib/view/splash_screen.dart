import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quidtrails/controller/db.dart';
import 'package:quidtrails/model/data.dart';
import 'package:quidtrails/model/user.dart';
import 'package:quidtrails/view/home_screen.dart';
import 'package:quidtrails/view/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<int> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('counter') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: 'assets/images/app_logo.png',
      screenFunction: () async {
        int counter = await getPrefs();
        await Provider.of<User>(context, listen: false).fetchUserDataFromDB();
        await Provider.of<Data>(context, listen: false).fetchExpenseTableData();
        return counter == 0 ? const WelcomeScreen() : const HomeScreen();
      },
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
    );
  }
}
