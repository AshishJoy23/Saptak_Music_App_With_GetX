import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/view/screens/search/widgets/recent_search_clear.dart';
import 'package:saptak_music_app/view/screens/search/widgets/searched_list_tile.dart';

import '../../../../controller/search_controller.dart';
import '../../../../model/database/db_all_models.dart';
import '../../../widgets/empty_list_screen.dart';

class SearchedScreenWidget extends StatelessWidget {
  const SearchedScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SearchController searchedController = Get.put(SearchController());
    final heightScrn = MediaQuery.of(context).size.height;
    return Obx(
      () => Column(
        children: [
          (searchedController.searchedSongs.isEmpty)
              ? const Expanded(
                  child: EmptyListScreenWidget(
                    message:
                        "You haven't searched anything ! \nSearch What You Want..",
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Recent Searches',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          RecentSearchClearButton(),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchedController.searchedSongs.length + 1,
                        itemBuilder: ((context, index) {
                          RecentSearches? currentSong;
                          if (index !=
                              searchedController.searchedSongs.length) {
                            currentSong =
                                searchedController.searchedSongs[index];
                          }

                          return (index ==
                                  searchedController.searchedSongs.length)
                              ? SizedBox(
                                  height: heightScrn * 0.08,
                                )
                              : SearchedListTileWidget(
                                  index: index, currentSong: currentSong);
                        }),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
