import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:saptak_music_app/controller/mostly_controller.dart';
import 'package:saptak_music_app/controller/recently_controller.dart';
import 'package:saptak_music_app/view/widgets/list_tile_leading.dart';
import 'package:saptak_music_app/view/widgets/mini_player.dart';

import '../../../../controller/home_controller.dart';
import '../../../../model/database/db_all_models.dart';
import '../../favorites/add_to_fav.dart';
import '../../playlists/add_to_playlist.dart';

class SongListTileWidget extends StatelessWidget {
  dynamic currentSong;
  List<Audio> convertAudios;
  int index;
  SongListTileWidget({
    super.key,
    required this.currentSong,
    required this.convertAudios,
    required this.index,
  });

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    final HomeController hController = Get.find<HomeController>();
    final MostlyController mController = Get.put(MostlyController());
    final RecentlyController recentController = Get.put(RecentlyController());
    RecentlyPlayed recentlySong;
    MostlyPlayed mostlySong;
    return ListTile(
      onTap: () {
        log(currentSong.songname.toString());
        recentlySong = RecentlyPlayed(
            songname: currentSong.songname,
            artist: currentSong.artist,
            duration: currentSong.duration,
            songuri: currentSong.songuri,
            id: currentSong.id);
        mostlySong = MostlyPlayed(
            songname: currentSong.songname!,
            songuri: currentSong.songuri,
            duration: currentSong.duration,
            artist: currentSong.artist,
            count: 1,
            id: currentSong.id);
        recentController.updateRecentlyPlayedSongs(recentlySong);
        mController.updateMostlyPlayedSongs(mostlySong);
        audioPlayer.open(Playlist(audios: convertAudios, startIndex: index),
            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
            loopMode: LoopMode.playlist,
            showNotification: true);
        Get.bottomSheet(
          Container(
            margin: const EdgeInsets.only(bottom:  50.0),
            child: MiniPlayer(index: index),
          ),
        );

      },
      leading: ListTileLeadingWidget(
        currentSong: currentSong,
      ),
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
            child: AddToFavorites(
                index: hController.dbAllSongs
                    .indexWhere((element) => element.id == currentSong.id)),
          ),
          PopupMenuItem<String>(
            value: "Playlists",
            child: AddToPlaylists(
                songIndex: hController.dbAllSongs
                    .indexWhere((element) => element.id == currentSong.id)),
          ),
        ],
      ),
    );
  }
}
