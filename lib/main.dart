import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quidtrails/model/data.dart';
import 'package:quidtrails/view/add_expense.dart';
import 'package:quidtrails/view/home_screen.dart';
import 'package:quidtrails/view/splash_screen.dart';
import 'package:quidtrails/view/welcome_screen.dart';

import 'model/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(create: (_) => User()),
        ChangeNotifierProvider<Data>(create: (_) => Data()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            titleTextStyle: TextStyle(
              fontFamily: "Railway",
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          fontFamily: "Railway",
        ),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          AddExpense.id: (context) => const AddExpense(),
        },
      ),
    );
  }
}
