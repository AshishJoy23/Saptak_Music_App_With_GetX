import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/controller/recently_controller.dart';
import 'package:saptak_music_app/view/screens/home/recently/recently_list_tile.dart';
import 'package:saptak_music_app/view/widgets/empty_list_screen.dart';
import '../../../../model/database/db_all_models.dart';
import '../../../../model/db_functions.dart';
import 'package:saptak_music_app/view/screens/search_screen.dart';

class ScreenRecently extends StatefulWidget {
  const ScreenRecently({super.key});

  @override
  State<ScreenRecently> createState() => _ScreenRecentlyState();
}

class _ScreenRecentlyState extends State<ScreenRecently> {
  String selectedItem = "Favorites";
  late int currentIndex;
  final box = AllSongsBox.getInstance();
  late List<AllSongs> allDbSongs;
  List<Audio> convertRSongs = [];
  List<RecentlyPlayed> recentlyDbSongs = [];
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");

  @override
  void initState() {
    allDbSongs = box.values.toList();
    recentlyDbSongs = recentlyPlayedBox.values.toList().reversed.toList();
    for (var element in recentlyDbSongs) {
      convertRSongs.add(Audio.file(element.songuri!,
          metas: Metas(
              artist: element.artist,
              title: element.songname,
              id: element.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RecentlyController rController = Get.put(RecentlyController());
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
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
                    title: 'Clear Your Recently Played Songs',
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
                          rController.clearRecentlyPlayedSongs();
                          Get.back();
                          Get.snackbar(
                            'Recently Played Songs',
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
          leading: IconButton(
              onPressed: () {
                //Navigator.pop(context);
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 28,
              )),
          title: const Text(
            'Recently Played',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 152, 248, 72),
            ),
          )),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10),
          child: (rController.recentlyDbSongs.isEmpty)
              ? const EmptyListScreenWidget(
                  message:
                      "You haven't played anything ! \nPlay What You Love..")
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: rController.recentlyDbSongs.length,
                  itemBuilder: (context, index) {
                    if (index == rController.recentlyDbSongs.length) {
                      return SizedBox(
                        height: height1 * 0.08,
                      );
                    }
                    return RecentlyListTileWidget(
                      currentSong: rController.recentlyDbSongs[index],
                      convertAudios: rController.convertRecentlyAudios,
                      index: index,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
