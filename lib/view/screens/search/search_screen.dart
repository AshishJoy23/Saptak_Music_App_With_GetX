import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saptak_music_app/controller/search_controller.dart';
import 'package:saptak_music_app/view/screens/search/widgets/search_appbar.dart';
import 'package:saptak_music_app/view/screens/search/widgets/searched_scrn_widget.dart';
import 'package:saptak_music_app/view/screens/search/widgets/searching_scrn_widget.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  // bool isSearched = false;
  @override
  Widget build(BuildContext context) {
    final SearchController sController = Get.put(SearchController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 28,
              color: Colors.white,
            )),
        title: const SearchAppbarWidget(),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8),
          child: (sController.isSearched.value)
              ? const SongSearchingScreenWidget()
              : const SearchedScreenWidget(),
        ),
      ),
    );
  }
}

