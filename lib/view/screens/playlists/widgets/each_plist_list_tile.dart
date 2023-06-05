import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:saptak_music_app/view/screens/favorites/add_to_fav.dart';
import 'package:saptak_music_app/view/screens/playlists/add_to_playlist.dart';
import 'package:saptak_music_app/view/screens/playlists/widgets/each_plist_remove_song.dart';

import '../../../../controller/home_controller.dart';
import '../../../../controller/mostly_controller.dart';
import '../../../../controller/playlist_controller.dart';
import '../../../../controller/recently_controller.dart';
import '../../../../model/database/db_all_models.dart';
import '../../../widgets/list_tile_leading.dart';
import '../../../widgets/mini_player.dart';

class EachPlaylistListTileWidget extends StatelessWidget {
  const EachPlaylistListTileWidget({
    super.key,
    required this.index,
    required this.playlistIndex,
    required this.currentSong,
    required this.currentPlaylist,
  });

  final int index;
  final int playlistIndex;
  final AllSongs currentSong;
  final Playlists currentPlaylist;

  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");
    final PlaylistController eachPlistListCntrl = Get.put(PlaylistController());
    final HomeController hController = Get.find<HomeController>();
    final MostlyController mController = Get.put(MostlyController());
    final RecentlyController rController = Get.put(RecentlyController());

    return ListTile(
      onTap: () {
        RecentlyPlayed recentlySong;
        MostlyPlayed mostlySong;
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
        rController.updateRecentlyPlayedSongs(recentlySong);
        mController.updateMostlyPlayedSongs(mostlySong);
        audioPlayer.open(
            Playlist(
                audios: eachPlistListCntrl.convertPlaylistAudios,
                startIndex: index),
            showNotification: true,
            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
            loopMode: LoopMode.playlist);
        showBottomSheet(
          context: context,
          builder: (context) {
            return MiniPlayer(
              index: hController.dbAllSongs.indexWhere(
                (element) => element.id == currentSong.id,
              ),
            );
          },
        );
      },
      leading: ListTileLeadingWidget(currentSong: currentSong),
      title: Marquee(
          animationDuration: const Duration(milliseconds: 5500),
          directionMarguee: DirectionMarguee.oneDirection,
          pauseDuration: const Duration(milliseconds: 1000),
          child: Text(
            currentSong.songname!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )),
      subtitle: currentSong.artist == '<unknown>'
          ? const Text(
              'Unknown Artist',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            )
          : Text(
              currentSong.artist!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
      trailing: PopupMenuButton<String>(
        color: Colors.grey,
        padding: const EdgeInsets.all(1.0),
        onSelected: (String value) {},
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: "Remove",
            child: PlaylistRemoveButtonWidget(
              songIndex: index,
              playlistIndex: playlistIndex,
              currentPlaylist: currentPlaylist,
              eachPlistListCntrl: eachPlistListCntrl,
            ),
          ),
          PopupMenuItem<String>(
            value: "Favorites",
            child: AddToFavorites(
              index: hController.dbAllSongs.indexWhere(
                (element) => element.id == currentSong.id,
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: "Playlists",
            child: AddToPlaylists(
              songIndex: hController.dbAllSongs.indexWhere(
                (element) => element.id == currentSong.id,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
