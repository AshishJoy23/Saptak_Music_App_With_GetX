import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/controller/favorites_controller.dart';
import 'package:saptak_music_app/view/screens/favorites/widgets/fav_list_tile.dart';
import 'package:saptak_music_app/view/screens/search_screen.dart';
import 'package:saptak_music_app/view/widgets/empty_list_screen.dart';
import '../../../model/database/db_all_models.dart';

class ScreenFavorites extends StatelessWidget {
  const ScreenFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController fController = Get.put(FavoritesController());

    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const ScreenSearch());
            },
            icon: const Icon(Icons.search_sharp,
                size: 28, color: Color.fromARGB(255, 152, 248, 72)),
          ),
          SizedBox(
            width: width1 * 0.01,
          ),
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Clear Your Favorites',
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
                        fController.clearFavoritesSongs();
                        Get.back();
                        Get.snackbar(
                          'Favorites Songs',
                          'Cleared Your Songs',
                          colorText: Colors.black,
                          duration: const Duration(milliseconds: 1500),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.grey,
                          reverseAnimationCurve: Curves.easeOut,
                        );
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                );
              },
              icon: const Icon(Icons.clear_all_sharp, size: 28)),
          SizedBox(
            width: width1 * 0.02,
          ),
        ],
        title: const Padding(
          padding: EdgeInsets.only(left: 40.0, bottom: 8.0),
          child: Text(
            'Favorites',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 152, 248, 72),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => (fController.favDbSongs.isEmpty)
              ? const EmptyListScreenWidget(
                  message: "You haven't added anything ! \nAdd What You Love..")
              : Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: fController.favDbSongs.length + 1,
                    itemBuilder: (context, index) {
                      List<Favorites> favoriteList =
                          fController.favDbSongs.toList().reversed.toList();
                      if (index == fController.favDbSongs.length) {
                        return SizedBox(
                          height: height1 * 0.08,
                        );
                      }
                      Favorites currentSong = favoriteList[index];
                      return FavoriteListTile(
                        currentSong: currentSong,
                        convertAudios: fController.convertFavAudios,
                        index: index,
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
