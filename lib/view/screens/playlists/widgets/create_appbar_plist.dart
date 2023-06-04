import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/playlist_controller.dart';

class CreateAppbarPlaylistWidget extends StatelessWidget {
  const CreateAppbarPlaylistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PlaylistController appbarPlaylistController =
        Get.put(PlaylistController());
    final textController = TextEditingController();
    return IconButton(
      onPressed: () {
        Get.defaultDialog(
          title: 'Create New Playlist',
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
                hintStyle:
                    TextStyle(color: Colors.black54, fontFamily: 'Poppins'),
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
                            'Create Playlist',
                            'Please Enter a Name',
                            colorText: Colors.black,
                            duration: const Duration(milliseconds: 1500),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.grey,
                            reverseAnimationCurve: Curves.easeOut,
                          );
                        },
                        child: const Text('Create'),
                      )
                    : ElevatedButton(
                        onPressed: (appbarPlaylistController
                                .checkIfPlaylistNameAlreadyExists(
                                    textController.text))
                            ? () {
                                textController.clear();
                                Get.snackbar(
                                  'Create Playlist',
                                  'Playlist Name Already Exists',
                                  colorText: Colors.black,
                                  duration: const Duration(milliseconds: 1500),
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.grey,
                                  reverseAnimationCurve: Curves.easeOut,
                                );
                              }
                            : () {
                                appbarPlaylistController.createPlaylist(
                                  null,
                                  textController.text,
                                );
                                textController.clear();
                                FocusManager.instance.primaryFocus?.unfocus();
                                Get.back();
                                Get.snackbar(
                                  'Create Playlist',
                                  'New Playlist Created',
                                  colorText: Colors.black,
                                  duration: const Duration(milliseconds: 1500),
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.grey,
                                  reverseAnimationCurve: Curves.easeOut,
                                );
                              },
                        child: const Text('Create'),
                      );
              },
            ),
          ],
        );
      },
      icon: const Icon(Icons.add_circle,
          size: 28, color: Color.fromARGB(255, 152, 248, 72)),
    );
  }
}
