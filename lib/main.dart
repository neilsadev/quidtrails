import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quidtrails/model/data.dart';
import 'package:quidtrails/view/home_screen.dart';
import 'package:quidtrails/view/welcome_screen.dart';

import 'model/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => User()),
        Provider(create: (_) => Data()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          WelcomeScreen.id: (context) => const WelcomeScreen(),
        },
      ),
    );
  }
}
