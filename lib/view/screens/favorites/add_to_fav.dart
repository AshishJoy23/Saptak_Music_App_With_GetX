import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/favorites_controller.dart';
import '../../../controller/home_controller.dart';

class AddToFavorites extends StatelessWidget {
  int index;
  AddToFavorites({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeCtrlr = Get.find<HomeController>();
    final FavoritesController favCtrlr = Get.put(FavoritesController());
    return favCtrlr.favDbSongs
            .where((element) => element.id == homeCtrlr.dbAllSongs[index].id)
            .isEmpty
        ? TextButton(
            onPressed: () {
              favCtrlr.addToFavorites(song: homeCtrlr.dbAllSongs[index]);
              Get.back();
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
            child: const Text(
              'Add to Favorites',
              style: TextStyle(fontSize: 14),
            ))
        : TextButton(
            onPressed: () {
              favCtrlr.removeFromFavorites(song: homeCtrlr.dbAllSongs[index]);
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
            child: const Text(
              'Remove from Favorites',
              style: TextStyle(fontSize: 14),
            ),
          );
  }
}
