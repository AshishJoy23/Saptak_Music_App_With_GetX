import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/playlist_controller.dart';
import '../../../../model/database/db_all_models.dart';

class PlaylistDeleteButtonWidget extends StatelessWidget {
  const PlaylistDeleteButtonWidget({
    super.key,
    required this.index,
    required this.currentPlaylist,
    required this.btnController,
  });
  final int index;
  final Playlists currentPlaylist;
  final PlaylistController btnController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.white.withOpacity(0.7),
            child: TextButton(
                onPressed: () {
                  Get.back();
                  Get.defaultDialog(
                    title: 'Delete ${currentPlaylist.playlistname} Playlist',
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
                          btnController.deletePlaylist(index);
                          Get.back();
                          Get.snackbar(
                            '${currentPlaylist.playlistname} Playlist',
                            'Playlist Deleted',
                            colorText: Colors.black,
                            duration: const Duration(
                                milliseconds: 1500),
                            snackPosition:
                                SnackPosition.BOTTOM,
                            backgroundColor: Colors.grey,
                            reverseAnimationCurve:
                                Curves.easeOut,
                          );
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
                child: const Text('Delete',
                    style: TextStyle(fontSize: 14),),),
          ),
        ),
      ],
    );
  }
}
