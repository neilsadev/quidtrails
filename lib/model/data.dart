import 'package:flutter/foundation.dart';
import 'package:quidtrails/controller/db.dart';
import 'package:quidtrails/model/constants.dart';

class Data extends ChangeNotifier {
  final DBProvider _dbProvider = DBProvider.instance;

  int? _initialBudget;
  int? _budgetLeft;
  int? _localTs;
  int? _dbTs;
  List<Map<String, dynamic>>? _expenseTableData;

  int? get initialBudget => _initialBudget;
  int? get budgetLeft => _budgetLeft;
  int? get localTs => _localTs;
  int? get dbTs => _dbTs;
  List<Map<String, dynamic>>? get expenseTableData => _expenseTableData;

  updateLocalTimeStamp() async {
    await _dbProvider.update(K.tableNameDBSync,
        {K.colNameDBSync["localTs"]!: DateTime.now().millisecondsSinceEpoch});
  }

  insertIntoExpenseTable(Map<String, dynamic> row) async {
    await _dbProvider.insert(K.tableNameExp, row);
    updateLocalTimeStamp();
  }

  fetchExpenseTableData() async {
    _expenseTableData = List<Map<String, dynamic>>.from(
        await _dbProvider.queryAll(K.tableNameExp));
    notifyListeners();
  }
}
