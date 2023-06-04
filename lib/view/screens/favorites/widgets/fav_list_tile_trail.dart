import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/controller/favorites_controller.dart';
import '../../../../controller/home_controller.dart';
import '../../playlists/add_to_playlist.dart';

class FavListTileTrailing extends StatelessWidget {
  final dynamic currentSong;
  const FavListTileTrailing({super.key, required this.currentSong});

  @override
  Widget build(BuildContext context) {
    final FavoritesController favController = Get.put(FavoritesController());
    final HomeController homeCtr = Get.find<HomeController>();
    return PopupMenuButton<String>(
      color: Colors.grey,
      padding: const EdgeInsets.all(1.0),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: "Favorites",
          child: TextButton(
            onPressed: () {
              Get.back();
              Get.defaultDialog(
                title: 'Remove from Favorites',
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
                      int index = homeCtr.dbAllSongs.indexWhere(
                          (element) => element.id == currentSong.id);
                      favController.removeFromFavorites(
                          song: homeCtr.dbAllSongs[index]);
                      Get.back();
                      Get.snackbar(
                        'Favorites Songs',
                        'Removed from Favorites',
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
              'Remove from Favorites',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: "Playlists",
          child: AddToPlaylists(
            songIndex: homeCtr.dbAllSongs
                .indexWhere((element) => element.id == currentSong.id),
          ),
        ),
      ],
    );
  }
}
