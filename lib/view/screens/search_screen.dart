import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:saptak_music_app/controller/home_controller.dart';
import 'package:saptak_music_app/controller/search_controller.dart';
import 'package:saptak_music_app/view/widgets/empty_list_screen.dart';
import 'package:saptak_music_app/view/widgets/list_tile_leading.dart';
import '../../../model/database/db_all_models.dart';
import '../../../model/db_functions.dart';
import 'package:saptak_music_app/view/screens/favorites/add_to_fav.dart';
import 'package:saptak_music_app/view/screens/playlists/add_to_playlist.dart';
import 'package:saptak_music_app/view/widgets/mini_player.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  // bool isSearched = false;
  @override
  Widget build(BuildContext context) {
    final SearchController sController = Get.put(SearchController());
    final HomeController hmController = Get.put(HomeController());
    AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
    final TextEditingController textController = TextEditingController();
    final heightScrn = MediaQuery.of(context).size.height;
    final widthScrn = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
              //Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 28,
              color: Colors.white,
            )),
        title: GestureDetector(
          child: TextField(
            cursorColor: Colors.white,
            cursorHeight: 28,
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onChanged: (value) {
              //filterList(value);
              sController.filterSearchingSongs(value);
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search_outlined,
                color: Colors.white,
                size: 26,
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    textController.clear();
                    sController.fetchAllSearchedSongs();
                    sController.isSearched.value = false;
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 26,
                  )),
              focusColor: Colors.white,
              hintText: 'Search Here.....',
              hintStyle:
                  const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
              filled: true,
              fillColor: const Color.fromARGB(255, 14, 17, 42),
            ),
            controller: textController,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8),
          child: (sController.isSearched.value)
              ? Column(
                  children: [
                    Expanded(
                      child: (sController.suggestionSongs.isEmpty)
                          ? const EmptyListScreenWidget(
                              message:
                                  "Ooops no matches found! \nSearch Other Song You Want..",
                            )
                          : ListView.builder(
                              itemCount: sController.suggestionSongs.length + 1,
                              itemBuilder: ((context, index) {
                                AllSongs? currentSong;
                                if (index !=
                                    sController.suggestionSongs.length) {
                                  currentSong =
                                      sController.suggestionSongs[index];
                                }
                                RecentSearches searchedSong;
                                return (index ==
                                        sController.suggestionSongs.length)
                                    ? SizedBox(
                                        height: heightScrn * 0.08,
                                      )
                                    : ListTile(
                                        onTap: () {
                                          searchedSong = RecentSearches(
                                              songname: currentSong!.songname,
                                              artist: currentSong.artist,
                                              duration: currentSong.duration,
                                              songuri: currentSong.songuri,
                                              id: currentSong.id);
                                          sController.addToSearchedSongs(
                                              currentSong: searchedSong);
                                          audioPlayer.open(
                                            Playlist(
                                                audios: sController
                                                    .convertSuggestionAudios,
                                                startIndex: index),
                                            showNotification: true,
                                            headPhoneStrategy: HeadPhoneStrategy
                                                .pauseOnUnplugPlayOnPlug,
                                            loopMode: LoopMode.playlist,
                                          );
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          showBottomSheet(
                                              context: context,
                                              builder: (ctx) {
                                                return MiniPlayer(
                                                    index: hmController
                                                        .dbAllSongs
                                                        .indexWhere((element) =>
                                                            element.id ==
                                                            currentSong!.id));
                                              });
                                        },
                                        leading: QueryArtworkWidget(
                                          artworkFit: BoxFit.cover,
                                          id: currentSong!.id!,
                                          type: ArtworkType.AUDIO,
                                          artworkQuality: FilterQuality.high,
                                          size: 2000,
                                          quality: 100,
                                          artworkBorder:
                                              BorderRadius.circular(10),
                                          nullArtworkWidget: Container(
                                            width: widthScrn * 0.134,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/images/saptak_icon.png')),
                                            ),
                                          ),
                                        ),
                                        title: Marquee(
                                            animationDuration: const Duration(
                                                milliseconds: 5500),
                                            directionMarguee:
                                                DirectionMarguee.oneDirection,
                                            pauseDuration: const Duration(
                                                milliseconds: 1000),
                                            child: Text(
                                              currentSong.songname!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            )),
                                        subtitle: currentSong.artist ==
                                                '<unknown>'
                                            ? const Text(
                                                'Unknown Artist',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                currentSong.artist!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.white),
                                              ),
                                      );
                              })),
                    ),
                  ],
                )
              : (sController.searchedSongs.isEmpty)
                  ? const EmptyListScreenWidget(
                      message:
                          "You haven't searched anything ! \nSearch What You Want..",
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Recent Searches',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white60.withOpacity(0.1)),
                                ),
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: 'Clear Your Search History',
                                    content: const Text('Are You Sure?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          sController.clearSearchedSongs();
                                          Get.back();
                                          Get.snackbar(
                                            'Recent Searches',
                                            'Cleared your Search History',
                                            colorText: Colors.black,
                                            duration: const Duration(
                                                milliseconds: 1500),
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.grey,
                                            reverseAnimationCurve:
                                                Curves.easeOut,
                                          );
                                        },
                                        child: const Text('Clear'),
                                      ),
                                    ],
                                  );
                                },
                                child: Row(
                                  children: const [
                                    Text(
                                      'Clear All',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white60),
                                    ),
                                    Icon(
                                      Icons.clear_all,
                                      size: 30,
                                      color: Colors.white60,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: sController.searchedSongs.length + 1,
                              itemBuilder: ((context, index) {
                                RecentSearches? currentSong;
                                if (index != sController.searchedSongs.length) {
                                  currentSong =
                                      sController.searchedSongs[index];
                                }

                                return (index ==
                                        sController.searchedSongs.length)
                                    ? SizedBox(
                                        height: heightScrn * 0.08,
                                      )
                                    : ListTile(
                                        onTap: () {
                                          RecentlyPlayed recentlySong;
                                          MostlyPlayed mostlySong;
                                          recentlySong = RecentlyPlayed(
                                              songname: currentSong!.songname,
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
                                          // updateRecentlyPlayed(recentlySong);
                                          // updateMostlyPlayed(mostlySong);
                                          audioPlayer.open(
                                            Playlist(
                                                audios: sController
                                                    .convertSearchedAudios,
                                                startIndex: index),
                                            showNotification: true,
                                            headPhoneStrategy: HeadPhoneStrategy
                                                .pauseOnUnplugPlayOnPlug,
                                            loopMode: LoopMode.playlist,
                                          );
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          showBottomSheet(
                                              context: context,
                                              builder: (ctx) {
                                                return MiniPlayer(
                                                    index: hmController
                                                        .dbAllSongs
                                                        .indexWhere((element) =>
                                                            element.id ==
                                                            currentSong!.id));
                                              });
                                        },
                                        leading: ListTileLeadingWidget(
                                          currentSong: currentSong,
                                        ),
                                        title: Marquee(
                                            animationDuration: const Duration(
                                                milliseconds: 5500),
                                            directionMarguee:
                                                DirectionMarguee.oneDirection,
                                            pauseDuration: const Duration(
                                                milliseconds: 1000),
                                            child: Text(
                                              currentSong!.songname!,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            )),
                                        subtitle: currentSong.artist ==
                                                '<unknown>'
                                            ? const Text(
                                                'Unknown Artist',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                currentSong.artist!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.white),
                                              ),
                                        trailing: PopupMenuButton<String>(
                                          color: Colors.grey,
                                          padding: const EdgeInsets.all(1.0),
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<String>>[
                                            PopupMenuItem<String>(
                                              value: "Favorites",
                                              child: AddToFavorites(
                                                  index: hmController.dbAllSongs
                                                      .indexWhere((element) =>
                                                          element.id ==
                                                          currentSong!.id)),
                                            ),
                                            PopupMenuItem<String>(
                                              value: "Playlists",
                                              child: AddToPlaylists(
                                                  songIndex: hmController
                                                      .dbAllSongs
                                                      .indexWhere((element) =>
                                                          element.id ==
                                                          currentSong!.id)),
                                            ),
                                          ],
                                        ),
                                      );
                              })),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
