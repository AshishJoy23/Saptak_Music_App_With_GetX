import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/model/database/db_all_models.dart';
import 'package:saptak_music_app/model/db_functions.dart';

class SearchController extends GetxController {
  var isSearched = false.obs;
  var convertSearchedAudios = <Audio>[].obs;
  var convertSuggestionAudios = <Audio>[].obs;
  var searchedSongs = <RecentSearches>[].obs;
  var suggestionSongs = <AllSongs>[].obs;

  final box = AllSongsBox.getInstance();

  @override
  void onInit() {
    suggestionSongs.value = box.values.toList();
    fetchAllSearchedSongs();
    super.onInit();
  }

  void fetchAllSearchedSongs() {
    searchedSongs.value = recentSearchesBox.values.toList().reversed.toList();
    convertSearchedAudios.clear();
    for (var element in searchedSongs) {
      convertSearchedAudios.add(
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
    for (var element in suggestionSongs) {
      convertSuggestionAudios.add(
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

  void clearSearchedSongs() async {
    await recentSearchesBox.clear();
    convertSearchedAudios.clear();
    searchedSongs.clear();
  }

  void addToSearchedSongs({required RecentSearches currentSong}) async {
    bool isAlreadyAdded = searchedSongs
        .where((song) => song.songname == currentSong.songname)
        .isNotEmpty;
    if (isAlreadyAdded) {
      int indexSearch = searchedSongs
          .indexWhere((element) => element.songname == currentSong.songname);
      searchedSongs.removeAt(indexSearch);
      searchedSongs.add(currentSong);
      await recentSearchesBox.addAll(searchedSongs);
      fetchAllSearchedSongs();
    } else {
      await recentSearchesBox.add(currentSong);
      fetchAllSearchedSongs();
    }
    fetchAllSearchedSongs();
  }

  filterSearchingSongs(String textQuery) {
    log('searching');
    isSearched.value = true;
    log(textQuery);
    if (textQuery == '') {
      suggestionSongs.value = box.values.toList();
    } else {
      suggestionSongs.value = box.values
          .where((element) =>
              element.songname!.toLowerCase().contains(textQuery.toLowerCase()))
          .toList();
      convertSuggestionAudios.clear();
      for (var item in suggestionSongs) {
        convertSuggestionAudios.add(
          Audio.file(
            item.songuri.toString(),
            metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString(),
            ),
          ),
        );
      }
    }
    log(suggestionSongs.toString());
  }
}
