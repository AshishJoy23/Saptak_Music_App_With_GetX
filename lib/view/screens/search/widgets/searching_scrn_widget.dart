import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/view/screens/search/widgets/searching_list_tile.dart';

import '../../../../controller/search_controller.dart';
import '../../../../model/database/db_all_models.dart';
import '../../../widgets/empty_list_screen.dart';

class SongSearchingScreenWidget extends StatelessWidget {
  const SongSearchingScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SearchController searchingController = Get.put(SearchController());
    final heightScrn = MediaQuery.of(context).size.height;
    return Obx(
      () => Column(
        children: [
          Expanded(
            child: (searchingController.suggestionSongs.isEmpty)
                ? const EmptyListScreenWidget(
                    message:
                        "Ooops no matches found! \nSearch Other Song You Want..",
                  )
                : ListView.builder(
                    itemCount: searchingController.suggestionSongs.length + 1,
                    itemBuilder: ((context, index) {
                      AllSongs? currentSong;
                      if (index != searchingController.suggestionSongs.length) {
                        currentSong =
                            searchingController.suggestionSongs[index];
                      }
                      return (index ==
                              searchingController.suggestionSongs.length)
                          ? SizedBox(
                              height: heightScrn * 0.08,
                            )
                          : SearchingListTileWidget(
                              index: index,
                              currentSong: currentSong,
                            );
                    }),
                  ),
          ),
        ],
      ),
    );
  }
}
