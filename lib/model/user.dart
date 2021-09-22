import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:quidtrails/controller/auth.dart';
import 'package:quidtrails/controller/db.dart';

import 'constants.dart';

class User extends ChangeNotifier {
  final DBProvider _dbProvider = DBProvider.instance;

  String? userName;
  String? userUID;
  String? currency;
  int? currencyMode;

  Future<bool> signInWithGoogle() async {
    UserCredential? userCredential = await Auth().signInWithGoogle();
    if (userCredential != null) {
      userName ??= userCredential.user?.displayName;
      userUID = userCredential.user?.uid;
      return true;
    }
    return false;
  }

  fetchUserDataFromDB() async {
    var userData = await _dbProvider.queryAll(K.tableNameUser);
    userName = userData[0][K.colNameUser["name"]!];
    currency = userData[0][K.colNameUser["currency"]!];
    currencyMode = userData[0][K.colNameUser["currencyMode"]!];
  }
}
