import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../search/search_screen.dart';

class EachPlaylistAppbarWidget extends StatelessWidget {
  const EachPlaylistAppbarWidget({
    super.key,
    required this.playlistName,
  });

  final String playlistName;

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: height1 * 0.06,
          right: width1 * 0.02,
          left: width1 * 0.02,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                    // Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: width1 * 0.04,
                ),
                Text(
                  '${playlistName[0].toUpperCase()}${playlistName.substring(1)} Playlist',
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                Get.to(
                  () => const ScreenSearch(),
                );
              },
              icon: const Icon(
                Icons.search_sharp,
                size: 28,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
