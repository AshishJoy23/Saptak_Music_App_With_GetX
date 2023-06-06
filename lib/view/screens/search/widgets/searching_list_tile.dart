import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';

import '../../../../controller/home_controller.dart';
import '../../../../controller/search_controller.dart';
import '../../../../model/database/db_all_models.dart';
import '../../../widgets/list_tile_leading.dart';
import '../../../widgets/mini_player.dart';

class SearchingListTileWidget extends StatelessWidget {
  const SearchingListTileWidget({
    super.key,
    required this.index,
    required this.currentSong,
  });

  final int index;
  final dynamic currentSong;

  @override
  Widget build(BuildContext context) {
    final SearchController searchingCtrl = Get.put(SearchController());
    final HomeController hmController = Get.put(HomeController());
    AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
    RecentSearches searchedSong;
    return ListTile(
      onTap: () {
        searchedSong = RecentSearches(
            songname: currentSong!.songname,
            artist: currentSong.artist,
            duration: currentSong.duration,
            songuri: currentSong.songuri,
            id: currentSong.id);
        searchingCtrl.addToSearchedSongs(currentSong: searchedSong);
        audioPlayer.open(
          Playlist(
              audios: searchingCtrl.convertSuggestionAudios, startIndex: index),
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
      leading: ListTileLeadingWidget(currentSong: currentSong),
      title: Marquee(
        animationDuration: const Duration(milliseconds: 5500),
        directionMarguee: DirectionMarguee.oneDirection,
        pauseDuration: const Duration(milliseconds: 1000),
        child: Text(
          currentSong!.songname!,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
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
    );
  }
}
