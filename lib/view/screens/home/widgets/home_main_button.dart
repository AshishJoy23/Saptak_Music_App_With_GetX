import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mostly/mostly.dart';
import '../recently/recently.dart';

class HomeMainButtonWidget extends StatelessWidget {
  const HomeMainButtonWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    final heightDsp = MediaQuery.of(context).size.height;
    final widthDsp = MediaQuery.of(context).size.width;
    return Container(
      width: widthDsp * 0.465,
      height: heightDsp * 0.075,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF00010A),
      ),
      child: InkWell(
        onTap: () {
          (title=='Recently Played')
          ?Get.to(const ScreenRecently())
          :Get.to(const ScreenMostly());
        },
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
