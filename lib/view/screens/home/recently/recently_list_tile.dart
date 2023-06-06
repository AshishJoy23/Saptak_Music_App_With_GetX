import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:saptak_music_app/view/widgets/list_tile_leading.dart';
import 'package:saptak_music_app/view/widgets/mini_player.dart';
import '../../../../controller/home_controller.dart';
import '../../favorites/add_to_fav.dart';
import '../../playlists/add_to_playlist.dart';

class RecentlyListTileWidget extends StatelessWidget {
  dynamic currentSong;
  List<Audio> convertAudios;
  int index;
  RecentlyListTileWidget({
    super.key,
    required this.currentSong,
    required this.convertAudios,
    required this.index,
  });

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    final HomeController hController = Get.find<HomeController>();
    return ListTile(
      onTap: () {
        audioPlayer.open(Playlist(audios: convertAudios, startIndex: index),
            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
            loopMode: LoopMode.playlist,
            showNotification: true);
        showBottomSheet(
          context: context,
          builder: (ctx) {
            return MiniPlayer(
              index: hController.dbAllSongs.indexWhere(
                (element) => element.id == currentSong.id,
              ),
            );
          },
        );
      },
      leading: ListTileLeadingWidget(currentSong: currentSong,),
      title: Marquee(
          animationDuration: const Duration(milliseconds: 5500),
          directionMarguee: DirectionMarguee.oneDirection,
          pauseDuration: const Duration(milliseconds: 1000),
          child: Text(
            currentSong.songname!,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          )),
      subtitle: currentSong.artist == '<unknown>'
          ? const Text(
              'Unknown Artist',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )
          : Text(
              currentSong.artist!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
      trailing: PopupMenuButton<String>(
        color: Colors.grey,
        padding: const EdgeInsets.all(1.0),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: "Favorites",
            child: AddToFavorites(index: hController.dbAllSongs.indexWhere((element) =>
                                  element.id == currentSong.id)),
          ),
          PopupMenuItem<String>(
            value: "Playlists",
            child: AddToPlaylists(songIndex: hController.dbAllSongs.indexWhere((element) =>
                                  element.id == currentSong.id)),
          ),
        ],
      ),
    );
  }
}

