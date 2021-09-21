import 'package:flutter/foundation.dart';
import 'package:quidtrails/controller/db.dart';
import 'package:quidtrails/model/constants.dart';

class Data extends ChangeNotifier {
  final DBProvider _dbProvider = DBProvider.instance;

  int? _initialBudget;
  int? _budgetLeft;
  String? _currency;
  int? _currencyMode;
  int? _localTs;
  int? _dbTs;
  List<Map<String, dynamic>>? _expenseTableData;

  int? get initialBudget => _initialBudget;
  int? get budgetLeft => _budgetLeft;
  String? get currency => _currency;
  int? get currencyMode => _currencyMode;
  int? get localTs => _localTs;
  int? get dbTs => _dbTs;
  dynamic get expenseTableData => _expenseTableData;

  updateLocalTimeStamp() async {}
  fetchExpenseTableData() async {
    _expenseTableData = List<Map<String, dynamic>>.from(
        await _dbProvider.queryAll(K.tableNameExp));
    notifyListeners();
  }
}
