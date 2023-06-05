import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_color_gen/material_color_gen.dart';

class SettingsListTileWidget extends StatelessWidget {
  const SettingsListTileWidget({
    super.key,
    required this.title,
    required this.onPressedPage,
  });
  final String title;
  final Widget onPressedPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF00010A).toMaterialColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        onTap: () {
          Get.to(() => onPressedPage);
        },
      ),
    );
  }
}
