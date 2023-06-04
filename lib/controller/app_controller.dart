import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/screens/favorites/favorites_list.dart';
import '../view/screens/home/home.dart';
import '../view/screens/playlists/playlists.dart';
import '../view/screens/settings/settings.dart';

class AppController extends GetxController {
  var selectedIndex = 0.obs;
  
  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }
  
  final screens = <Widget>[
    const ScreenHome(),
    const ScreenFavorites(),
    const ScreenPlaylists(),
    const ScreenSettings(),
  ];
}