import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/playlist_controller.dart';
import '../../../../model/database/db_all_models.dart';

class PlaylistRemoveButtonWidget extends StatelessWidget {
  const PlaylistRemoveButtonWidget({
    super.key,
    required this.songIndex,
    required this.playlistIndex,
    required this.currentPlaylist,
    required this.eachPlistListCntrl,
  });

  final int songIndex;
  final int playlistIndex;
  final Playlists currentPlaylist;
  final PlaylistController eachPlistListCntrl;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.back();
        Get.defaultDialog(
          title: 'Remove from ${currentPlaylist.playlistname} Playlist',
          content: const Text('Are You Sure?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                eachPlistListCntrl.removeFromPlaylist(songIndex, playlistIndex);
                //eachPlistListCntrl.fetchCurrentPlaylistSongs(playlistIndex);
                Get.back();
                Get.snackbar(
                  'Remove from Playlist',
                  'Removed from ${currentPlaylist.playlistname} Playlist',
                  colorText: Colors.black,
                  duration: const Duration(milliseconds: 1500),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.grey,
                  reverseAnimationCurve: Curves.easeOut,
                );
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
      child: const Text(
        'Remove Song',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
