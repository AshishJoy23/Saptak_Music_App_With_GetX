import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/playlist_controller.dart';
import '../../../../model/database/db_all_models.dart';

class PlaylistRenameButtonWidget extends StatelessWidget {
  const PlaylistRenameButtonWidget({
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
    final textController = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.white.withOpacity(0.7),
            child: TextButton(
              onPressed: () {
                textController.text = currentPlaylist.playlistname!;
                Get.back();
                Get.defaultDialog(
                  title: 'Rename the Playlist',
                  content: GestureDetector(
                    child: TextField(
                      controller: textController,
                      cursorColor: Colors.black,
                      cursorHeight: 28,
                      onTapOutside: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Icon(
                          Icons.playlist_add,
                          color: Colors.black,
                          size: 26,
                        ),
                        focusColor: Colors.black,
                        hintText: 'Enter the Name...',
                        hintStyle: TextStyle(
                            color: Colors.black54, fontFamily: 'Poppins'),
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                        textController.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: const Text('Cancel'),
                    ),
                    ValueListenableBuilder(
                      valueListenable: textController,
                      builder: (context, value, child) {
                        return (textController.text.isEmpty)
                            ? TextButton(
                                onPressed: () {
                                  Get.snackbar(
                                    'Rename Playlist',
                                    'Please Enter a Name',
                                    colorText: Colors.black,
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.grey,
                                    reverseAnimationCurve: Curves.easeOut,
                                  );
                                },
                                child: const Text('Rename'),
                              )
                            : ElevatedButton(
                                onPressed: (btnController
                                        .checkIfPlaylistNameAlreadyExists(
                                            textController.text))
                                    ? () {
                                        textController.clear();
                                        Get.snackbar(
                                          'Create Playlist',
                                          'Playlist Name Already Exists',
                                          colorText: Colors.black,
                                          duration: const Duration(
                                              milliseconds: 1500),
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.grey,
                                          reverseAnimationCurve: Curves.easeOut,
                                        );
                                      }
                                    : () {
                                        btnController.renamePlaylist(
                                            index, textController.text);
                                        textController.clear();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        Get.back();
                                        Get.snackbar(
                                          'Rename Playlist',
                                          'Playlist Renamed',
                                          colorText: Colors.black,
                                          duration: const Duration(
                                              milliseconds: 1500),
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.grey,
                                          reverseAnimationCurve: Curves.easeOut,
                                        );
                                      },
                                child: const Text('Rename'),
                              );
                      },
                    ),
                  ],
                );
              },
              child: const Text(
                'Rename',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
