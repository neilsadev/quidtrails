class Formatter {
  String displayAmount({
    required int amount,
    required String currency,
    int currencyMode = 1,
  }) {
    late String returnStr;
    switch (currencyMode) {
      case 1:
        returnStr = "$amount$currencyMode";
        break;
      case 2:
        returnStr = "$amount $currencyMode";
        break;
      case 3:
        returnStr = "$currencyMode$amount";
        break;
      case 4:
        returnStr = "$currencyMode $amount";
        break;
      default:
        returnStr = "$amount$currencyMode";
        break;
    }
    return returnStr;
  }
}
