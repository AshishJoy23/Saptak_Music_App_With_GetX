import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/home_controller.dart';
import '../../playlists/add_from_now.dart';

class NowPlayingAppbarWidget extends StatelessWidget {
  const NowPlayingAppbarWidget({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final HomeController npAppbarHController = Get.put(HomeController());
    final heightDsp = MediaQuery.of(context).size.height;
    final widthDsp = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: heightDsp * 0.06, horizontal: widthDsp * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 28,
                color: Colors.white,
              )),
          AddPlstFromNow(
              songIndex: npAppbarHController.dbAllSongs
                  .indexWhere((element) => element.id == int.parse(id)))
        ],
      ),
    );
  }
}
