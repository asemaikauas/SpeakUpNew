import 'package:flutter/material.dart';
import 'package:speakup/common/widgets/appbar.dart';
import 'package:speakup/util/constants/image_strings.dart';
import 'package:speakup/util/constants/sizes.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SAppBar(
        title: "Логопедические  центры",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SSizes.defaultSpace),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(SImages.gMap),
                const SizedBox(height: 50),
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
