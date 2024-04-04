import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup/common/widgets/appbar.dart';
import 'package:speakup/features/speakup/controllers/speech_controller.dart';
import 'package:speakup/util/constants/image_strings.dart';
import 'package:speakup/util/constants/sizes.dart';
import 'package:speakup/util/device/device_utility.dart';

import '../../../util/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  final SpeechController speechController = Get.put(SpeechController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SAppBar(
        title: "SpeakUP AI Чат",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Image.asset(SImages.robot)],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(SSizes.spaceBtwSections * 2),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        height: SDeviceUtils.getScreenHeight(context) * .4,
        width: SDeviceUtils.getScreenWidth(context),
        child: Column(
          children: [
            Obx(() {
              return Text(
                speechController.isListening ? "Слушаю... " : "",
                style: Theme.of(context).textTheme.titleLarge,
              );
            }),
            const SizedBox(height: SSizes.spaceBtwSections),
            IconButton(
              icon: const Icon(
                Icons.mic,
                color: Colors.white,
              ),
              iconSize: 100,
              onPressed: () {
                speechController.isListening = !speechController.isListening;
                speechController.listen();
              },
              style: IconButton.styleFrom(
                backgroundColor: SColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
