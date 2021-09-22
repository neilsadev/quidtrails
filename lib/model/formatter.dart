class Formatter {
  RegExp commaNumberRegEx = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  String displayAmount({
    required int amount,
    required String currency,
    int currencyMode = 1,
  }) {
    late String returnStr;
    String amountStr = amount
        .toString()
        .replaceAllMapped(commaNumberRegEx, (match) => '${match[1]},');
    switch (currencyMode) {
      case 1:
        returnStr = "$amountStr$currency";
        break;
      case 2:
        returnStr = "$amountStr $currency";
        break;
      case 3:
        returnStr = "$currency$amountStr";
        break;
      case 4:
        returnStr = "$currency $amountStr";
        break;
      default:
        returnStr = "$amountStr$currency";
        break;
    }
    return returnStr;
  }
}
