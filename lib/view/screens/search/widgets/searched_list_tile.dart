import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';

import '../../../../controller/home_controller.dart';
import '../../../../controller/mostly_controller.dart';
import '../../../../controller/recently_controller.dart';
import '../../../../controller/search_controller.dart';
import '../../../../model/database/db_all_models.dart';
import '../../../widgets/list_tile_leading.dart';
import '../../../widgets/mini_player.dart';
import '../../favorites/add_to_fav.dart';
import '../../playlists/add_to_playlist.dart';

class SearchedListTileWidget extends StatelessWidget {
  const SearchedListTileWidget({
    super.key,
    required this.index,
    required this.currentSong,
  });

  final int index;
  final RecentSearches? currentSong;

  @override
  Widget build(BuildContext context) {
    final SearchController searchedCtrl = Get.put(SearchController());
    final MostlyController searchedMCtrl = Get.put(MostlyController());
    final RecentlyController searchedRCtrl = Get.put(RecentlyController());
    final HomeController hmController = Get.put(HomeController());
    AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
    return ListTile(
      onTap: () {
        RecentlyPlayed recentlySong;
        MostlyPlayed mostlySong;
        recentlySong = RecentlyPlayed(
            songname: currentSong!.songname,
            artist: currentSong!.artist,
            duration: currentSong!.duration,
            songuri: currentSong!.songuri,
            id: currentSong!.id);
        mostlySong = MostlyPlayed(
            songname: currentSong!.songname!,
            songuri: currentSong!.songuri,
            duration: currentSong!.duration,
            artist: currentSong!.artist,
            count: 1,
            id: currentSong!.id);
        searchedMCtrl.updateMostlyPlayedSongs(mostlySong);
        searchedRCtrl.updateRecentlyPlayedSongs(recentlySong);
        audioPlayer.open(
          Playlist(
              audios: searchedCtrl.convertSearchedAudios, startIndex: index),
          showNotification: true,
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
          loopMode: LoopMode.playlist,
        );
        FocusManager.instance.primaryFocus?.unfocus();
        showBottomSheet(
          context: context,
          builder: (ctx) {
            return MiniPlayer(
              index: hmController.dbAllSongs.indexWhere(
                (element) => element.id == currentSong!.id,
              ),
            );
          },
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
            currentSong!.songname!,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          )),
      subtitle: currentSong!.artist == '<unknown>'
          ? const Text(
              'Unknown Artist',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )
          : Text(
              currentSong!.artist!,
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
              index: hmController.dbAllSongs.indexWhere(
                (element) => element.id == currentSong!.id,
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: "Playlists",
            child: AddToPlaylists(
              songIndex: hmController.dbAllSongs.indexWhere(
                (element) => element.id == currentSong!.id,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
