import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/controller/app_controller.dart';
import 'package:saptak_music_app/model/database/db_all_models.dart';

class MyMusicApp extends StatelessWidget {
  MyMusicApp({super.key});
  int? currentIndex;
  int? totalLength;
  AllSongs? currentSong;

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());
    final heightDsp = MediaQuery.of(context).size.height;
    return Obx(
      () => Scaffold(
        body: appController.screens[appController.selectedIndex.value],
        //body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavyBar(
          items: <BottomNavyBarItem>[
            bottomNavBarItems(
              bottomNavIcon: Icons.home_outlined,
              bottomNavLabel: 'Home',
            ),
            bottomNavBarItems(
              bottomNavIcon: Icons.favorite_outline,
              bottomNavLabel: 'Favorite',
            ),
            bottomNavBarItems(
              bottomNavIcon: Icons.playlist_add,
              bottomNavLabel: 'Playlists',
            ),
            bottomNavBarItems(
              bottomNavIcon: Icons.settings_outlined,
              bottomNavLabel: 'Settings',
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 0, 1, 10),
          selectedIndex: appController.selectedIndex.value,
          showElevation: true,
          iconSize: 30,
          containerHeight: heightDsp * 0.075,
          itemCornerRadius: 28,
          curve: Curves.easeIn,
          onItemSelected: (index) => appController.changeSelectedIndex(index),
        ),
      ),
    );
  }

  BottomNavyBarItem bottomNavBarItems({
    required bottomNavIcon,
    required bottomNavLabel,
  }) {
    return BottomNavyBarItem(
      icon: Icon(bottomNavIcon),
      title: Text(bottomNavLabel, style: const TextStyle(fontSize: 15)),
      inactiveColor: Colors.white,
      activeColor: const Color.fromARGB(255, 152, 248, 72),
    );
  }

}
