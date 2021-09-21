import 'dart:ui';

class K {
  // Table constants for sqlite

  // expense_table
  //   category       |  description             |  amount        |  datetime
  // -----------------|--------------------------|----------------|----------------
  //   Food           |  Breakfast               |  30$           |  17-09-2021 8:49 AM
  //   Travel         |  Bus (home to office)    |  20$           |  17-09-2021 9:32 AM

  // Expense table will have all individual expense entries as a row at this
  // table. "category" will be predefined with categories list variable. Or
  // if the user selects "Other" as the category option, then the "title"
  // will be inputted in the category column of that entry.
  // Only the description field will be nullable field.

  static const String tableNameExp = "expense_table";
  static const Map<String, String> colNameExp = {
    "category": "category",
    "description": "description",
    "amount": "amount",
    "dateTime": "datetime",
  };

  // summery_table
  //   month          |  budget                  |  spent
  // -----------------|--------------------------|----------------
  //   January        |  5000$                   |  4250$
  //   February       |  5000$                   |  5200$
  //   March          |  5500$                   |  550$

  // Summery Table will store monthly budget and spent on the rows
  // Initially the default budget from the user table will be set as
  // the budget for the month. But user can change it any time.
  // The spent row will initially be zero. On every expense user add
  // to the expense table. the amount from that expense will be added to
  // this spent row.

  static const String tableNameSummery = "summery_table";
  static const Map<String, String> colNameSummery = {
    "month": "month",
    "budget": "budget",
    "spent": "spent",
  };

  // db_sync_table
  //   name           |  currency   |   currency_mode |   image       |    remote_uid
  // -----------------|--------------------------------------------------------------------
  //   John Doe       |  $          |   1             |   base64Str   |   Firebase UID

  // User table is for saving the users settings to the device. It will have
  // only one row. It will store the users name, default currency, how
  // the currency will show, a base 64 version of their image. And if the
  // user is connected to Google, it will store their UID. Also this table
  // will be synced to database as well

  static const String tableNameUser = "user_table";
  static const Map<String, String> colNameUser = {
    "name": "name",
    "currency": "currency",
    "currencyMode": "currency_mode",
    "image": "image",
    "remoteUID": "remote_uid",
  };

  // db_sync_table
  //   local_ts       |  db_ts
  // -----------------|----------------
  //   123456789      |  123456789

  // DB Sync Table is only to keep track of database (Cloud Firestore) and
  // local sqlite database. It will take two timestamp as its value.
  // On every database write, this local_ts will be updated to current
  // timestamp. And If there is internet connection exists and user
  // have signed in with google, we check the two timestamps. If the
  // local timestamp is greater than the database timestamp. We will update
  // the local database to the server and update the server timestamp and
  // set it as equal to local_ts.

  static const String tableNameDBSync = "db_sync_table";
  static const Map<String, String> colNameDBSync = {
    "localTs": "local_ts",
    "dbTs": "db_ts",
  };

  // Colors
  static const Color black = Color(0xFF171717);
  static const Color purple = Color(0xFF6B50A0);
}
