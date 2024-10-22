import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup/features/speakup/models/user_model.dart';
import 'package:speakup/features/speakup/screens/home_screen.dart';
import 'package:speakup/util/helpers/firebase_hepler.dart';
import 'package:speakup/util/helpers/helper_functions.dart';

class SignUpController extends GetxController {
  /// Text Fields Controller
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController rePassword = TextEditingController();

  /// Password Visibility Toggles
  RxBool isPasswordVisible = false.obs;
  RxBool isRePasswordVisible = false.obs;

  /// Fields Validations Function
  void signUp(BuildContext context,
      {required String fullName,
      required String email,
      required String password,
      required String rePassword}) {
    if (email.isNotEmpty &&
        fullName.isNotEmpty &&
        password.isNotEmpty &&
        rePassword.isNotEmpty) {
      if (SHelperFunctions.isEmailValid(email: email)) {
        if (password == rePassword) {
          /// Call SignUp User Function
          signUpUser(context, email: email, password: password)
              .then((value) async {
            try {
              /// Create User Model
              final UserModel user = UserModel(
                userId: SFireHelper.fireAuth.currentUser!.uid,
                displayName: fullName,
                email: email,
                password: password,
              );

              /// Upload User data
              await uploadUserData(user).then((value) {
                SHelperFunctions.hideProgressIndicator();
                Get.offAll(() => HomeScreen());
              });
            } catch (e) {
              SHelperFunctions.showSnackBar(
                  'Error occurred during registration. $e');
            }
          });
        } else {
          SHelperFunctions.showSnackBar("Passwords do not match");
        }
      } else {
        SHelperFunctions.showSnackBar("Invalid email");
      }
    } else {
      SHelperFunctions.showSnackBar("Please fill in all fields");
    }
  }

  /// Upload User To FireStore Function
  Future<void> uploadUserData(UserModel user) async {
    try {
      await SFireHelper.fireStore
          .collection("Users")
          .doc(SFireHelper.fireAuth.currentUser!.uid)
          .set(user.toJson());
    } catch (e) {
      SHelperFunctions.hideProgressIndicator();
      SHelperFunctions.showSnackBar("Error uploading data: $e");
    }
  }

  /// User SignUp With Mail & Password Function
  Future<void> signUpUser(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    SHelperFunctions.showProgressIndicator(context);
    try {
      await SFireHelper.fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      SHelperFunctions.hideProgressIndicator();
      if (e.code == 'weak-password') {
        SHelperFunctions.showSnackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        SHelperFunctions.showSnackBar(
            'The account already exists for that email.');
      }
    } catch (e) {
      SHelperFunctions.hideProgressIndicator();
      SHelperFunctions.showSnackBar(e.toString());
    }
  }
}
