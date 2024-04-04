import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speakup/common/widgets/appbar.dart';
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
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset(SImages.gMap),
                SizedBox(
                  height: Get.height*0.3,
                  width: Get.width,
                  child: const GoogleMap(

                    initialCameraPosition: CameraPosition(
                      target: LatLng(55.7558, 37.6173), // San Francisco coordinates
                      zoom: 12.0,
                    ),
                  ),
                ),
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
