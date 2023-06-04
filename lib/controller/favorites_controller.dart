import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import '../model/database/db_all_models.dart';
import '../model/db_functions.dart';

class FavoritesController extends GetxController {
  var  convertFavAudios = <Audio>[].obs;
  var favDbSongs = <Favorites>[].obs;

  @override
  void onInit() {
    fetchAllSongs();
    super.onInit();
  }

  void fetchAllSongs() {
    favDbSongs.value = favSongsBox.values.toList();
    convertFavAudios.clear();
    for (var element in favDbSongs) {
      convertFavAudios.add(
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

  void clearFavoritesSongs() {
    favSongsBox.clear();
    convertFavAudios.clear();
    favDbSongs.clear();
  }

  void addToFavorites({required AllSongs song}) async{
    await favSongsBox.add(
      Favorites(
        songname: song.songname,
        artist: song.artist,
        duration: song.duration,
        songuri: song.songuri,
        id: song.id,
      ),
    );
    fetchAllSongs();
  }
  void removeFromFavorites({required AllSongs song}) async{
    final currentIndex = favDbSongs.indexWhere((element) => element.id == song.id);
    await favSongsBox.deleteAt(currentIndex);
    fetchAllSongs();
  }
}