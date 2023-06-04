import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:saptak_music_app/controller/mostly_controller.dart';
import 'package:saptak_music_app/controller/recently_controller.dart';
import 'package:saptak_music_app/view/screens/favorites/widgets/fav_list_tile_trail.dart';
import '../../../../controller/home_controller.dart';
import '../../../../model/database/db_all_models.dart';
import '../../../widgets/list_tile_leading.dart';
import '../../../widgets/mini_player.dart';

class FavoriteListTile extends StatelessWidget {
  final dynamic currentSong;
  final List<Audio> convertAudios;
  final int index;
  const FavoriteListTile({
    super.key,
    required this.currentSong,
    required this.convertAudios,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController home = Get.find<HomeController>();
    final RecentlyController recentlyCtrlr = Get.put(RecentlyController());
    final MostlyController mostlyCtrlr = Get.put(MostlyController());
    AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
    final height1 = MediaQuery.of(context).size.height;
    RecentlyPlayed recentlySong;
    MostlyPlayed mostlySong;
    return ListTile(
      onTap: () {
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
        recentlyCtrlr.updateRecentlyPlayedSongs(recentlySong);
        mostlyCtrlr.updateMostlyPlayedSongs(mostlySong);
        audioPlayer.open(Playlist(audios: convertAudios, startIndex: index),
            showNotification: true,
            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
            loopMode: LoopMode.playlist);
        Get.bottomSheet(
            Container(
              margin: EdgeInsets.only(bottom: height1 * 0.075),
              child: MiniPlayer(
                  index: home.dbAllSongs
                      .indexWhere((element) => element.id == currentSong.id)),
            ),
            useRootNavigator: false);
      },
      leading: ListTileLeadingWidget(currentSong: currentSong),
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
      trailing: FavListTileTrailing(
        currentSong: currentSong,
      ),
    );
  }
}
