import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/model/database/db_all_models.dart';

import '../model/db_functions.dart';

class RecentlyController extends GetxController {
  var recentlyDbSongs = <RecentlyPlayed>[].obs;
  var convertRecentlyAudios = <Audio>[].obs;
  

  @override
  void onInit() {
    fetchAllSongs();
    super.onInit();
  }

  void fetchAllSongs() {
    recentlyDbSongs.value = recentlyPlayedBox.values.toList().reversed.toList();
    convertRecentlyAudios.clear();
    for (var element in recentlyDbSongs) {
      convertRecentlyAudios.add(
        Audio.file(
          element.songuri!,
          metas: Metas(
            title: element.songname,
            artist: element.artist,
            id: element.id.toString(),
          ),
        ),
      );
    }
  }

  void clearRecentlyPlayedSongs() {
    recentlyPlayedBox.clear();
    convertRecentlyAudios.clear();
    recentlyDbSongs.clear();
  }

  void updateRecentlyPlayedSongs(RecentlyPlayed currentSong) async{
    List<RecentlyPlayed> recentList = recentlyPlayedBox.values.toList();
    bool isAlreadyAdded = recentList.where((song) => song.songname==currentSong.songname).isNotEmpty;
    if(isAlreadyAdded){
      int indexRecently = recentList.indexWhere((element) => element.songname==currentSong.songname);
      await recentlyPlayedBox.deleteAt(indexRecently);
      recentlyDbSongs.removeAt(indexRecently);
      await recentlyPlayedBox.add(currentSong);
      fetchAllSongs();
    } else{
      await recentlyPlayedBox.add(currentSong);
      fetchAllSongs();
    }
  }
}
