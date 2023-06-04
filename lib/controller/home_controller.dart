import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';

import '../model/database/db_all_models.dart';

class HomeController extends GetxController {
  var time = DateTime.now().obs;

  final box = AllSongsBox.getInstance();
  var dbAllSongs = <AllSongs>[].obs;
  var convertAllAudios = <Audio>[].obs;

  @override
  void onInit() {
    fetchAllSongs();
    super.onInit();
  }

  void fetchAllSongs() {
    dbAllSongs.value = box.values.toList();

    for (var element in dbAllSongs) {
      convertAllAudios.add(
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
}
