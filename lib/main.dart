import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup/features/authentication/screens/login_screen.dart';
import 'package:speakup/firebase_options.dart';
import 'package:speakup/util/theme/theme.dart';

main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SpeakUp());
}

class SpeakUp extends StatelessWidget {
  const SpeakUp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: STheme.sTheme,
      home: const LoginScreen(),
    );
  }
}
