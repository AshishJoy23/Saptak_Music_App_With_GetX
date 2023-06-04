import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/model/db_functions.dart';
import '../model/database/db_all_models.dart';

class MostlyController extends GetxController {
  var mostlyDbSongs = <MostlyPlayed>[].obs;
  var convertMostlyAudios = <Audio>[].obs;
  var mostlySongs = <MostlyPlayed>[].obs;

  @override
  void onInit() {
    fetchAllSongs();
    super.onInit();
  }

  void fetchAllSongs() {
    mostlyDbSongs.value = mostlyPlayedBox.values.toList();
    mostlySongs.value = mostlyDbSongs.where((song) => song.count > 5).toList();
    mostlySongs.sort((a, b) => b.count.compareTo(a.count));
    convertMostlyAudios.clear();
    for (var element in mostlySongs) {
      convertMostlyAudios.add(
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

  void clearMostlyPlayedSongs() {
    mostlyPlayedBox.clear();
    mostlySongs.clear();
    convertMostlyAudios.clear();
    mostlyDbSongs.clear();
  }

  void updateMostlyPlayedSongs(MostlyPlayed currentSong) async{
    bool isAlreadyAdded = mostlyDbSongs.where((song) => song.songname==currentSong.songname).isNotEmpty;
    if(isAlreadyAdded){
      int indexMostly = mostlyDbSongs.indexWhere((element) => element.songname==currentSong.songname);
      currentSong.count = mostlyDbSongs[indexMostly].count + 1;
      await mostlyPlayedBox.putAt(indexMostly, currentSong);
      fetchAllSongs();
    } else{
      await mostlyPlayedBox.add(currentSong);
      fetchAllSongs();
    }
  }
}
