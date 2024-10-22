import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup/features/authentication/controllers/signup_controller.dart';
import 'package:speakup/util/constants/sizes.dart';
import 'package:speakup/util/device/device_utility.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpCtrl = Get.put(SignUpController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SSizes.defaultSpace),
            child: Center(
              child: SizedBox(
                width: SDeviceUtils.getScreenWidth(context) * .8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: signUpCtrl.fullName,
                      decoration: const InputDecoration(
                        hintText: "ФИО",
                        prefixIcon: Icon(Icons.person_outlined),
                      ),
                    ),
                    const SizedBox(height: SSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: signUpCtrl.email,
                      decoration: const InputDecoration(
                        hintText: "Электронная почта",
                      ),
                    ),
                    const SizedBox(height: SSizes.spaceBtwInputFields),
                    Obx(() => TextFormField(
                          controller: signUpCtrl.password,
                          obscureText: !signUpCtrl.isPasswordVisible.value,
                          decoration: InputDecoration(
                            hintText: "Пароль",
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                signUpCtrl.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                signUpCtrl.isPasswordVisible.value =
                                    !signUpCtrl.isPasswordVisible.value;
                              },
                            ),
                          ),
                        )),
                    const SizedBox(height: SSizes.spaceBtwInputFields),
                    Obx(() => TextFormField(
                          controller: signUpCtrl.rePassword,
                          obscureText: !signUpCtrl.isRePasswordVisible.value,
                          decoration: InputDecoration(
                            hintText: "Подтвердите пароль",
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                signUpCtrl.isRePasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                signUpCtrl.isRePasswordVisible.value =
                                    !signUpCtrl.isRePasswordVisible.value;
                              },
                            ),
                          ),
                        )),
                    const SizedBox(height: SSizes.spaceBtwSections),
                    SizedBox(
                      width: SDeviceUtils.getScreenWidth(context) * .8,
                      child: ElevatedButton(
                          onPressed: () => signUpCtrl.signUp(
                                context,
                                fullName: signUpCtrl.fullName.text,
                                email: signUpCtrl.email.text,
                                password: signUpCtrl.password.text,
                                rePassword: signUpCtrl.rePassword.text,
                              ),
                          child: const Text("SIGN UP")),
                    ),
                    const SizedBox(height: SSizes.spaceBtwSections / 2),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
