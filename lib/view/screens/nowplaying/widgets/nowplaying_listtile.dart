import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';

import '../../../../controller/home_controller.dart';
import '../../favorites/add_fav_from_now.dart';

class NowPlayingListTileWidget extends StatelessWidget {
  const NowPlayingListTileWidget({
    super.key,
    required this.id,
    required this.currentAudioTitle,
    required this.currentAudioArtist,
  });

  final String id;
  final String currentAudioTitle;
  final String currentAudioArtist;

  @override
  Widget build(BuildContext context) {
    final HomeController npTileHController = Get.put(HomeController());
    return ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      title: Marquee(
          animationDuration: const Duration(milliseconds: 5500),
          directionMarguee: DirectionMarguee.oneDirection,
          pauseDuration: const Duration(milliseconds: 1000),
          child: Text(
            currentAudioTitle,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          )),
      subtitle: Text(
        currentAudioArtist == '<unknown>'
            ? 'Unknown Artist'
            : currentAudioArtist,
        maxLines: 1,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: AddFavFromNow(
        index: npTileHController.dbAllSongs.indexWhere(
          (element) => element.id == int.parse(id),
        ),
      ),
    );
  }
}
