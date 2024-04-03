import 'package:flutter/material.dart';
import 'package:speakup/util/constants/sizes.dart';
import 'package:speakup/util/device/device_utility.dart';

class SAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: SSizes.md, vertical: SSizes.sm / 2),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
            child: Text(title),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(SDeviceUtils.getAppBarHeight());
}
