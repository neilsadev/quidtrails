import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:quidtrails/controller/auth.dart';
import 'package:quidtrails/controller/db.dart';
import 'package:quidtrails/model/formatter.dart';

import 'constants.dart';

class User extends ChangeNotifier {
  final DBProvider _dbProvider = DBProvider.instance;

  String? _userName;
  String? _userUID;
  String? _currency;
  int? _currencyMode;
  int? _thisMonthsBudget;
  int? _thisMonthsBudgetLeft;

  // get data from user class
  String? get currency => _currency;
  int? get currencyMode => _currencyMode;
  String? get userName => _userName;
  int? get thisMonthsBudget => _thisMonthsBudget;
  int? get thisMonthsBudgetLeft => _thisMonthsBudgetLeft;

  Future<bool> signInWithGoogle() async {
    UserCredential? userCredential = await Auth().signInWithGoogle();
    if (userCredential != null) {
      _userName ??= userCredential.user?.displayName;
      _userUID = userCredential.user?.uid;
      return true;
    }
    return false;
  }

  fetchUserDataFromDB() async {
    var userData = await _dbProvider.queryAll(K.tableNameUser);
    _userName = userData[0][K.colNameUser["name"]!];
    _currency = userData[0][K.colNameUser["currency"]!];
    _currencyMode = userData[0][K.colNameUser["currencyMode"]!];
    var budgetData = await _dbProvider.query(K.tableNameSummery,
        where: "${K.colNameSummery["month"]} = ?",
        whereArgs: [Formatter().formattedDate(DateTime.now())]);
    if (budgetData.isNotEmpty) {
      _thisMonthsBudget = budgetData[0][K.colNameSummery["budget"]!];
      int? spent = budgetData[0][K.colNameSummery["spent"]!];
      if (_thisMonthsBudget != null && spent != null) {
        _thisMonthsBudgetLeft = _thisMonthsBudget! - spent;
      }
    }
  }
}
