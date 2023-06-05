import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/view/screens/playlists/widgets/bottomsheet_list_tile.dart';
import 'package:saptak_music_app/view/screens/playlists/widgets/create_playlist.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/playlist_controller.dart';

class AddPlstFromNow extends StatelessWidget {
  int songIndex;
  AddPlstFromNow({super.key, required this.songIndex});

  @override
  Widget build(BuildContext context) {
    final PlaylistController playlstController = Get.put(PlaylistController());
    final HomeController hmCntrl = Get.find<HomeController>();
    return IconButton(
      onPressed: (playlstController.allDbPlaylists.isEmpty)
          ? () {
              // Get.back();
              Get.bottomSheet(
                CreatePlaylist(currentIndex: songIndex),
              );
            }
          : () {
              // Get.back();
              Get.bottomSheet(
                DraggableScrollableSheet(
                  initialChildSize: 0.7,
                  maxChildSize: 0.7,
                  minChildSize: 0.1,
                  builder: (context, controller) {
                    return Container(
                      color: const Color.fromARGB(255, 14, 17, 42),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CreatePlaylist(currentIndex: songIndex),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    playlstController.allDbPlaylists.length,
                                physics: const NeverScrollableScrollPhysics(),
                                controller: controller, // set this too
                                itemBuilder: (context, index) =>
                                    BottomSheetListTileWidget(
                                  songIndex: songIndex,
                                  playlistIndex: index,
                                  playlstController: playlstController,
                                  hmCntrl: hmCntrl,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
      icon: const Icon(
        Icons.playlist_add,
        color: Colors.white,
        size: 36,
      ),
    );
  }
}
