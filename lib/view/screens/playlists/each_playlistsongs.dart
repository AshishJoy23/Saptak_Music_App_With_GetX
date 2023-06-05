import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/view/screens/playlists/widgets/each_plist_appbar.dart';
import 'package:saptak_music_app/view/screens/playlists/widgets/each_plist_emptyscrn.dart';
import 'package:saptak_music_app/view/screens/playlists/widgets/each_plist_list_tile.dart';
import 'package:saptak_music_app/view/screens/playlists/widgets/plist_first_song_image.dart';
import '../../../controller/playlist_controller.dart';
import '../../../model/database/db_all_models.dart';

class EachPlaylistSongs extends StatelessWidget {
  Playlists currentPlaylist;
  int playlistIndex;
  EachPlaylistSongs({
    super.key,
    required this.currentPlaylist,
    required this.playlistIndex,
  });

  @override
  Widget build(BuildContext context) {
    final PlaylistController plstController = Get.put(PlaylistController());
    final height1 = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Obx(
        () => (plstController
                .allDbPlaylists[playlistIndex].playlistssongs!.isEmpty)
            ? EachPlaylistEmptyScreen(
                playlistName: currentPlaylist.playlistname!,
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    EachPlaylistAppbarWidget(
                      playlistName: currentPlaylist.playlistname!,
                    ),
                    PlaylistFirstSongImageWidget(
                      currentPlaylistSongs: currentPlaylist.playlistssongs!,
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentPlaylist.playlistssongs!.length + 1,
                      itemBuilder: (context, index) {
                        late AllSongs currentSong;
                        if (index != currentPlaylist.playlistssongs!.length) {
                          currentSong = currentPlaylist.playlistssongs![index];
                        }
                        return (index == currentPlaylist.playlistssongs!.length)
                            ? SizedBox(
                                height: height1 * 0.08,
                              )
                            : EachPlaylistListTileWidget(
                                index: index,
                                playlistIndex: playlistIndex,
                                currentSong: currentSong,
                                currentPlaylist: currentPlaylist,
                              );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
