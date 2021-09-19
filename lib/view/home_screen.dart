import 'dart:typed_data';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quidtrails/model/data.dart';
import 'package:quidtrails/model/user.dart';
import 'package:quidtrails/model/formatter.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/images/app_logo.png"),
        title: Text(Provider.of<User>(context).userName ?? "User"),
        actions: [
          CircleAvatar(
            backgroundImage: Provider.of<User>(context).image != null
                ? Image.memory(
                    Uint8List.fromList(Provider.of<User>(context).image!),
                  ).image
                : const AssetImage("assets/images/default_avatar.png"),
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              EvaIcons.settings2Outline,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: const Color(0xFF171717),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Text("Budget left"),
                        // Text(Formatter().displayAmount(amount: Provider.of<Data>(context).budgetLeft!,currency: Provider.of<Data>(context).currency!, currencyMode: Provider.of<Data>(context).currencyMode!)),
                        Text("5000\$"),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
