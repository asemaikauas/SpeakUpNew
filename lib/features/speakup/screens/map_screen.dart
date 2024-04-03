import 'package:flutter/material.dart';
import 'package:speakup/common/widgets/appbar.dart';
import 'package:speakup/util/constants/image_strings.dart';
import 'package:speakup/util/constants/sizes.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
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
                Text("Алмата:"),
                Text("ldjbv"),
                Text("Алмата:"),
                Text("sjbjl"),
                Text("sljbljsb"),
                Text("slkbnslk"),
                SizedBox(height: SSizes.spaceBtwItems),
                Text("Астана:"),
                Text("ldkbn"),
                Text("sljbvls"),
                Text("slfkbnlb"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
