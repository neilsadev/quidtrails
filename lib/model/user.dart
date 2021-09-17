import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:quidtrails/controller/auth.dart';
import 'package:quidtrails/controller/network.dart';

class User extends ChangeNotifier {
  String? userName;
  String? userEmail;
  String? userUID;
  List<int>? image;
  String? currency;
  int? currencyMode;

  Future<bool> signInWithGoogle() async {
    UserCredential? userCredential = await Auth().signInWithGoogle();
    if (userCredential != null) {
      userName ??= userCredential.user?.displayName;
      userEmail = userCredential.user?.email;
      userUID = userCredential.user?.uid;
      if (userCredential.user?.photoURL != null) {
        image = await Network()
            .loadNetworkImage(Uri.tryParse(userCredential.user!.photoURL!));
      }
      return true;
    }
    return false;
  }
}
