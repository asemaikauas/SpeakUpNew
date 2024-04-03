import 'package:flutter/material.dart';
import 'package:speakup/common/widgets/appbar.dart';
import 'package:speakup/util/constants/sizes.dart';
import 'package:speakup/util/device/device_utility.dart';

import '../../../util/constants/colors.dart';

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SAppBar(
        title: "SpeakUP AI Валли",
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SSizes.defaultSpace),
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
            Text(
              "Слушаю... ",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: SSizes.spaceBtwSections),
            IconButton(
              icon: const Icon(
                Icons.mic,
                color: Colors.white,
              ),
              iconSize: 100,
              onPressed: () {},
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
