import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/controller/home_controller.dart';
import '../../../../controller/playlist_controller.dart';

class CreatePlaylist extends StatelessWidget {
  int currentIndex;
  CreatePlaylist({super.key, required this.currentIndex});

  // final TextEditingController playlistController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final PlaylistController createPlaylistController =
        Get.put(PlaylistController());
    final HomeController homeController = Get.find<HomeController>();
    final TextEditingController textController = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Get.back();
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
                              onPressed: (createPlaylistController
                                      .checkIfPlaylistNameAlreadyExists(
                                          textController.text))
                                  ? () {
                                      textController.clear();
                                      Get.snackbar(
                                        'Create Playlist',
                                        'Playlist Name Already Exists',
                                        colorText: Colors.black,
                                        duration:
                                            const Duration(milliseconds: 1500),
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.grey,
                                        reverseAnimationCurve: Curves.easeOut,
                                      );
                                    }
                                  : () {
                                      createPlaylistController.createPlaylist(
                                        homeController.dbAllSongs[currentIndex],
                                        textController.text,
                                      );
                                      textController.clear();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      Get.back();
                                      Get.snackbar(
                                        'Create Playlist',
                                        'New Playlist Created and the Song is Added.',
                                        colorText: Colors.black,
                                        duration:
                                            const Duration(milliseconds: 1500),
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
              //Navigator.pop(context);
              // showDialog(
              //     context: context,
              //     builder: (BuildContext ctx) {
              //       return AlertDialog(
              //         title: const Text('Create New Playlist'),
              //         content: GestureDetector(
              //       child: TextField(
              //         controller: playlistController,
              //         cursorColor: Colors.black,
              //         cursorHeight: 28,
              //         onTap: () {
              //           FocusManager.instance.primaryFocus?.unfocus();
              //         },
              //         onChanged: (value) {

              //         },
              //         decoration: const InputDecoration(
              //           focusedBorder: UnderlineInputBorder(
              //             borderSide: BorderSide(color: Colors.black),
              //           ),
              //           prefixIcon: Icon(
              //             Icons.playlist_add,
              //             color: Colors.black,
              //             size: 26,
              //           ),
              //           focusColor: Colors.black,
              //           hintText: 'Enter the Name...',
              //           hintStyle:
              //               TextStyle(color: Colors.black54, fontFamily: 'Poppins'),
              //           // filled: true,
              //           // fillColor: Color.fromARGB(255, 14, 17, 42),
              //         ),

              //         style: const TextStyle(
              //           fontSize: 18,
              //           fontFamily: 'Poppins',
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //         actions: [
              //           TextButton(
              //               onPressed: () {
              //                 Navigator.of(ctx).pop();
              //                 playlistController.clear();
              //               },
              //               child: const Text('Cancel')),
              //           ValueListenableBuilder<TextEditingValue>(
              //             valueListenable: playlistController,
              //             builder: (context, value, child) {
              //               if (playlistController.text.isEmpty) {
              //                 return TextButton(
              //                 onPressed: () {
              //                   ScaffoldMessenger.of(ctx).showSnackBar(
              //                     const SnackBar(
              //                       content: Text('Please Enter a Name'),
              //                       duration: Duration(milliseconds: 600),
              //                     ),
              //                   );
              //                 },
              //                 child: const Text('Create')
              //               );
              //               } else {
              //                 return ElevatedButton(
              //                 onPressed: (checkIfAlreadyExists(playlistController.text))
              //                 ? (){
              //                   playlistController.clear();
              //                   ScaffoldMessenger.of(ctx).showSnackBar(
              //                     const SnackBar(
              //                       content: Text('Playlist Already Exists'),
              //                       duration: Duration(milliseconds: 600),
              //                     ),
              //                   );
              //                 }
              //                 :() {
              //                   playlistsBox.add(
              //                     Playlists(
              //                       playlistname: playlistController.text,
              //                       playlistssongs: [AllSongs(
              //                         songname: allDbSongs[widget.currentIndex].songname,
              //                         artist: allDbSongs[widget.currentIndex].artist,
              //                         duration: allDbSongs[widget.currentIndex].duration,
              //                         id: allDbSongs[widget.currentIndex].id,
              //                         songuri: allDbSongs[widget.currentIndex].songuri)
              //                       ],
              //                     ));
              //                     playlistController.clear();
              //                   Navigator.of(ctx).pop();
              //                   ScaffoldMessenger.of(ctx).showSnackBar(
              //                     const SnackBar(
              //                       content: Text('New Playlist Created and the Song is Added.'),
              //                       duration: Duration(milliseconds: 800),
              //                     ),
              //                   );
              //                 },
              //                 child: const Text('Create')
              //               );
              //              }

              //             },
              //           ),
              //         ],
              //       );
              //     });
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            ),
            icon: const Icon(Icons.playlist_add),
            label: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Text(
                'Create New Playlist',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
