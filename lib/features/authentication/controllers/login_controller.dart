import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup/util/helpers/helper_functions.dart';

class LoginController extends GetxController {
  /// Text Fields Controller
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  /// LoginUp & Fields Validations
  void login(
    context, {
    required String email,
    required String password,
  }) {
    if (email.isNotEmpty && password.isNotEmpty) {
      if (SHelperFunctions.isEmailValid(email: email)) {
        loginUser(context, email: email, password: password);
      } else {
        SHelperFunctions.showSnackBar("Your email invalid");
      }
    } else {
      SHelperFunctions.showSnackBar("Please Fill All Fields");
    }
  }

  /// User Login With Email & Password Function
  Future<void> loginUser(context,
      {required String email, required String password}) async {
    SHelperFunctions.showProgressIndicator(context);
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .onError((error, stackTrace) {
        SHelperFunctions.hideProgressIndicator();
        SHelperFunctions.showSnackBar(error.toString());
        throw error as Object;
      }).then((value) {
        SHelperFunctions.hideProgressIndicator();
        SHelperFunctions.showSnackBar('User Successfully Login');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SHelperFunctions.hideProgressIndicator();
        SHelperFunctions.showSnackBar('No user found for that email.');
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        SHelperFunctions.hideProgressIndicator();
        SHelperFunctions.showSnackBar('Wrong password provided for that user.');
        // print('Wrong password provided for that user.');
      }
    } catch (e) {
      SHelperFunctions.hideProgressIndicator();
      SHelperFunctions.showSnackBar(e.toString());
    }
  }
}
