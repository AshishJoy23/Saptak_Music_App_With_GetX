import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/controller/home_controller.dart';
import 'package:saptak_music_app/view/widgets/empty_list_screen.dart';
import 'package:saptak_music_app/view/screens/home/widgets/song_list_tile.dart';

class ScreenAllSongs extends StatelessWidget {
  const ScreenAllSongs({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final heightDsp = MediaQuery.of(context).size.height;
    return (controller.dbAllSongs.isEmpty)
        ? const EmptyListScreenWidget(message: "No Songs Found, Sorry..")
        : Obx(
            () => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.dbAllSongs.length + 1,
              itemBuilder: (context, index) {
                return (index == controller.dbAllSongs.length)
                    ? SizedBox(
                        height: heightDsp * 0.08,
                      )
                    : SongListTileWidget(
                        currentSong: controller.dbAllSongs[index],
                        convertAudios: controller.convertAllAudios,
                        index: index,
                      );
              },
            ),
          );
  }
}
