import 'package:flutter/foundation.dart';

class Data extends ChangeNotifier {
  int? _initialBudget;
  int? _budgetLeft;
  String? _currency;
  int? _currencyMode;
  int? _localTs;
  int? _dbTs;

  int? get initialBudget => _initialBudget;
  int? get budgetLeft => _budgetLeft;
  String? get currency => _currency;
  int? get currencyMode => _currencyMode;
  int? get localTs => _localTs;
  int? get dbTs => _dbTs;

  updateLocalTimeStamp() async {}
}
