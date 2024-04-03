import 'package:flutter/material.dart';
import 'package:speakup/util/constants/sizes.dart';
import 'package:speakup/util/device/device_utility.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // leading: Icon(Icons.arrow_back),
        // leading: Icon(Icons.arrow_back),
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: SSizes.md, vertical: SSizes.sm / 2),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              child: const Text("Завести аккаунт"),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Center(
            child: SizedBox(
              width: SDeviceUtils.getScreenWidth(context) * .8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: SDeviceUtils.getScreenWidth(context) * .25,
                    child: Icon(
                      Icons.person_outlined,
                      size: SDeviceUtils.getScreenWidth(context) * .4,
                    ),
                  ),
                  const SizedBox(height: SSizes.spaceBtwSections * 2),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "ЭФИО",
                      prefixIcon: Icon(Icons.person_outlined),
                    ),
                  ),
                  const SizedBox(height: SSizes.spaceBtwInputFields),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Электронная почта ",
                    ),
                  ),
                  const SizedBox(height: SSizes.spaceBtwInputFields),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Пароль",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: SSizes.spaceBtwInputFields),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Подтвердите пароль",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: SSizes.spaceBtwSections),
                  SizedBox(
                      width: SDeviceUtils.getScreenWidth(context) * .8,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("SIGN UP"))),
                  const SizedBox(height: SSizes.spaceBtwSections / 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
