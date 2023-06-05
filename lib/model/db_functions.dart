import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:saptak_music_app/model/database/db_all_models.dart';



late Box<RecentlyPlayed> recentlyPlayedBox;
openRecentlyPlayedDb() async {
  recentlyPlayedBox = await Hive.openBox('recentlyplayed');
}

late Box<MostlyPlayed> mostlyPlayedBox;
openMostlyPlayedDb() async {
  mostlyPlayedBox = await Hive.openBox('mostlyplayed');
}

late Box<Favorites> favSongsBox;
openFavoriteSongsDb() async {
  favSongsBox = await Hive.openBox('favoritesongs');
}

late Box<Playlists> playlistsBox;
openPlaylistsDb() async {
  playlistsBox = await Hive.openBox('playlists');
}

late Box<RecentSearches> recentSearchesBox;
openRecentSearchesDb() async {
  recentSearchesBox = await Hive.openBox('recentsearches');
}

void requestPermission() async{
  final audioQuery = OnAudioQuery();
  final box = AllSongsBox.getInstance();
  List<SongModel> fetchedSongs=[];
  List<SongModel> allSongs=[];
    //Permission.storage.request();
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {// check for permission
      await audioQuery.permissionsRequest();// if permission not given, request it
    
      fetchedSongs = await audioQuery.querySongs();// fetch from internal storage and store in list
      log('fetched');
      for(var element in fetchedSongs){
        if (element.fileExtension=='mp3') {
          allSongs.add(element);//filtering mp3 audios and adding to allSongs list
        }
      }

      for (var element in allSongs) {
        box.add(AllSongs(  //addings songs into allSongs box
          songname: element.title, 
          artist: element.artist, 
          duration: element.duration, 
          id: element.id, 
          songuri: element.uri));
      }
    }
  }

updateRecentlyPlayed(RecentlyPlayed song){
  List<RecentlyPlayed> recentList = recentlyPlayedBox.values.toList();
  bool isNotPresent = recentList.where((element)
  {
    //check whether the current song is in the recently played
    //if not then isNotPresent becomes true otherwise false
    return element.songname == song.songname;
  }).isEmpty;
  if (isNotPresent == true) {
    recentlyPlayedBox.add(song);//if it is not present then add it
  }else{
    int indexRecent = recentList.indexWhere((element) => 
    element.songname==song.songname);  //if it is present find its index
    recentlyPlayedBox.deleteAt(indexRecent);  //delete the song at that index 
    recentlyPlayedBox.add(song); // add again the song to the recentlyPlayedBox
  }
}

updateMostlyPlayed(MostlyPlayed song){
  List<MostlyPlayed> mostlyList = mostlyPlayedBox.values.toList();
  bool isNotPresent = mostlyList.where((element)
  {
    //check whether the current song is in the recently played
    //if not then isNotPresent becomes true otherwise false
    return element.songname == song.songname;
  }).isEmpty;
  if (isNotPresent == true) {
    mostlyPlayedBox.add(song);//if it is not present then add it
  }else{
    int indexRecent = mostlyList.indexWhere((element) => 
    element.songname==song.songname);  //if it is present find its index
    int count = mostlyList[indexRecent].count; // find the count of current song
    song.count= count+1; // increment by 1 and update box
    mostlyPlayedBox.put(indexRecent, song);//update the box by the new count of the song
  }
}

updateRecentSearches(RecentSearches song){
  List<RecentSearches> recentSearchesList = recentSearchesBox.values.toList();
  bool isNotPresent = recentSearchesList.where((element)
  {
    return element.songname == song.songname;
  }).isEmpty;
  if (isNotPresent == true) {
    recentSearchesBox.add(song);//if it is not present then add it
  }else{
    int indexRecent = recentSearchesList.indexWhere((element) => 
    element.songname==song.songname);  //if it is present find its index
    recentSearchesBox.deleteAt(indexRecent);  //delete the song at that index 
    recentSearchesBox.add(song); // add again the song to the recentSearchesBox
  }
}
