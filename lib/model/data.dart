import 'package:flutter/foundation.dart';

class Data extends ChangeNotifier {
  int? _localTs;
  int? _dbTs;

  int? get localTs => _localTs;
  int? get dbTs => _dbTs;

  updateLocalTimeStamp() async {}
}
