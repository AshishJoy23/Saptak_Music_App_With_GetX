import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/model/database/db_all_models.dart';

import '../model/db_functions.dart';

class PlaylistController extends GetxController {
  var allDbPlaylists = <Playlists>[].obs;
  var convertPlaylistAudios = <Audio>[].obs;

  @override
  void onInit() {
    fetchAllPlaylists();
    super.onInit();
  }

//fetching all playlists from playlistsBox
  void fetchAllPlaylists() {
    allDbPlaylists.value = playlistsBox.values.toList();
  }

//creating a new playlist and adding the current song in it
  void createPlaylist(AllSongs? currentSong, String textQuery) async {
    if (currentSong == null) {
      await playlistsBox.add(
        Playlists(
          playlistname: textQuery,
          playlistssongs: [],
        ),
      );
      fetchAllPlaylists();
    } else {
      await playlistsBox.add(
        Playlists(
          playlistname: textQuery,
          playlistssongs: [
            AllSongs(
              songname: currentSong.songname,
              artist: currentSong.artist,
              duration: currentSong.duration,
              id: currentSong.id,
              songuri: currentSong.songuri,
            )
          ],
        ),
      );
      fetchAllPlaylists();
    }
  }

//creating a new playlist without adding song in it
  // void appbarCreatePlaylist({AllSongs? currentSong,required String textQuery}) async{
  //   if (currentSong==null) {
  //     await playlistsBox.add(
  //     Playlists(
  //       playlistname: textQuery,
  //       playlistssongs: [],
  //     ),
  //   );
  //   fetchAllPlaylists();
  //   }

  // }

//adding song to the exixting playlists
  void addToPlaylist(int index, AllSongs currentSong) async {
    List<AllSongs> currentPlaylistSongs =
        allDbPlaylists[index].playlistssongs!.toList();
    currentPlaylistSongs.add(
      AllSongs(
        songname: currentSong.songname,
        artist: currentSong.artist,
        duration: currentSong.duration,
        id: currentSong.id,
        songuri: currentSong.songuri,
      ),
    );
    await playlistsBox.putAt(
      index,
      Playlists(
        playlistname: allDbPlaylists[index].playlistname,
        playlistssongs: currentPlaylistSongs,
      ),
    );
    fetchAllPlaylists();
  }

//removing song from the exixting playlists
  void removeFromPlaylist(int songIndex, int playlistIndex) async {
    List<AllSongs> currentPlaylistSongs =
        allDbPlaylists[playlistIndex].playlistssongs!.toList();
    currentPlaylistSongs.removeAt(songIndex);
    Playlists updatedPlaylist = Playlists(
      playlistname: allDbPlaylists[playlistIndex].playlistname,
      playlistssongs: currentPlaylistSongs,
    );
    await playlistsBox.put(playlistIndex, updatedPlaylist);
    convertPlaylistSongs(playlistIndex);
  }

//deleting the current playlist
  void deletePlaylist(int index) async {
    await playlistsBox.deleteAt(index);
    fetchAllPlaylists();
  }

//renaming the current playlist
  void renamePlaylist(int index, String textQuery) async {
    final currentPlaylist = allDbPlaylists[index];
    currentPlaylist.playlistname = textQuery;
    await playlistsBox.putAt(index, currentPlaylist);
    fetchAllPlaylists();
  }

//converting the songs in the current playlist to the asset audio format
  void convertPlaylistSongs(int index) {
    List<AllSongs> currentPlaylistSongs =
        allDbPlaylists[index].playlistssongs!.toList();
    convertPlaylistAudios.clear();
    for (var element in currentPlaylistSongs) {
      convertPlaylistAudios.add(
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

//check whether the playlist name entered by user already exists or not
  bool checkIfPlaylistNameAlreadyExists(String textQuery) {
    bool isAlreadyAddedName = allDbPlaylists
        .where((element) => element.playlistname == textQuery.trim())
        .isNotEmpty;
    return isAlreadyAddedName;
  }

//check whether the song added by the user already exists in the playlist or not
  bool checkSongExistsInPlaylist(int index, AllSongs currentSong) {
    List<AllSongs> currentPlaylistSongs =
        allDbPlaylists[index].playlistssongs!.toList();
    bool isAlreadyAddedSong =
        currentPlaylistSongs.any((element) => element.id == currentSong.id);
    return isAlreadyAddedSong;
  }
}
