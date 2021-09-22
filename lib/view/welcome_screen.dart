import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quidtrails/controller/db.dart';
import 'package:quidtrails/model/user.dart';

import 'package:quidtrails/model/constants.dart';
import 'package:quidtrails/view/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _dbProvider = DBProvider.instance;

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
                child: Image.asset("assets/images/big_logo.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 50),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () async {
                    bool status =
                        await Provider.of<User>(context, listen: false)
                            .signInWithGoogle();
                    if (status == true) {
                      Map<String, dynamic> row = {
                        K.colNameUser["name"]!:
                            Provider.of<User>(context, listen: false).userName,
                      };
                      await _dbProvider.update(K.tableNameUser, row);
                      Navigator.popAndPushNamed(context, HomeScreen.id);
                    }
                  },
                  color: Colors.white,
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/google_logo.png",
                          width: 40,
                        ),
                      ),
                      const Text(
                        "Sign in with Google",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("continue without signing in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
