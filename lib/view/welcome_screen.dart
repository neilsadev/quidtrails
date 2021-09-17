import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quidtrails/model/user.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Image.asset("assets/images/logo_big.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
                child: MaterialButton(
                  onPressed: () async {
                    bool status =
                        await Provider.of<User>(context, listen: false)
                            .signInWithGoogle();
                    print(Provider.of<User>(context, listen: false).userName);
                    print(Provider.of<User>(context, listen: false).userEmail);
                    print(Provider.of<User>(context, listen: false).userUID);
                  },
                  color: Colors.white,
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/images/small_logo.png",
                        ),
                      ),
                      Text("Sign in with Google"),
                      SizedBox(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}