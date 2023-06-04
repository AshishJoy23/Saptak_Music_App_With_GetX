import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/view/screens/playlists/widgets/each_playlistsongs.dart';
import 'package:saptak_music_app/view/screens/playlists/widgets/playlist_delete_button.dart';
import 'package:saptak_music_app/view/screens/playlists/widgets/playlist_rename_button.dart';
import '../../../../controller/playlist_controller.dart';
import '../../../../model/database/db_all_models.dart';
import '../../../widgets/list_tile_leading.dart';

class PlaylistListTileWidget extends StatelessWidget {
  const PlaylistListTileWidget({
    super.key,
    required this.index,
    required this.currentPlaylist,
    required this.tileController,
  });
  final int index;
  final Playlists currentPlaylist;
  final PlaylistController tileController;

  @override
  Widget build(BuildContext context) {
    final widthDsp = MediaQuery.of(context).size.height;
    return ListTile(
      onTap: () {
        Get.to(() => EachPlaylistSongs(
              playlist: currentPlaylist,
              index: index,
            ));
      },
      leading: (currentPlaylist.playlistssongs!.isEmpty)
          ? Container(
              width: widthDsp * 0.065,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/images/saptak_icon.png')),
              ),
              //child: Icon(Icons.abc),
            )
          : ListTileLeadingWidget(
              currentSong:
                  currentPlaylist.playlistssongs!.first),
      title: Text(
        currentPlaylist.playlistname!,
        style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            color: Colors.white),
      ),
      subtitle: Text(
        (currentPlaylist.playlistssongs!.length <= 1)
            ? '${currentPlaylist.playlistssongs!.length.toString()} Song'
            : '${currentPlaylist.playlistssongs!.length.toString()} Songs',
        style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            color: Colors.white),
      ),
      trailing: PopupMenuButton<String>(
        color: Colors.white.withOpacity(0.7),
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: "Delete",
            child: PlaylistDeleteButtonWidget(index: index,currentPlaylist: currentPlaylist, btnController: tileController,),
          ),
          PopupMenuItem<String>(
            value: "Rename",
            child: PlaylistRenameButtonWidget(index: index, currentPlaylist: currentPlaylist, btnController: tileController,),
          ),
        ],
      ),
    );
  }
}
