import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/favorites_controller.dart';
import '../../../controller/home_controller.dart';

class AddFavFromNow extends StatelessWidget {
  int index;
  AddFavFromNow({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeCtrler = Get.find<HomeController>();
    final FavoritesController favCtrler = Get.put(FavoritesController());
    return Obx(
      () => favCtrler.favDbSongs
              .where((element) => element.id == homeCtrler.dbAllSongs[index].id)
              .isEmpty
          ? IconButton(
              onPressed: () {
                favCtrler.addToFavorites(song: homeCtrler.dbAllSongs[index]);
                Get.snackbar(
                  'Favorites Songs',
                  'Added to Favorites',
                  colorText: Colors.black,
                  duration: const Duration(milliseconds: 1500),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.grey,
                  reverseAnimationCurve: Curves.easeOut,
                );
              },
              icon: const Icon(
                Icons.favorite_border_sharp,
                color: Colors.white,
                size: 35,
              ),
            )
          : IconButton(
              onPressed: () {
                favCtrler.removeFromFavorites(
                    song: homeCtrler.dbAllSongs[index]);
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
              icon: const Icon(
                Icons.favorite_border_sharp,
                color: Color.fromARGB(255, 152, 248, 72),
                size: 35,
              ),
            ),
    );
  }
}
