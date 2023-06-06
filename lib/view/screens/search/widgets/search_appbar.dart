import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/search_controller.dart';

class SearchAppbarWidget extends StatelessWidget {
  const SearchAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SearchController searchAppbarController = Get.put(SearchController());
    final TextEditingController textController = TextEditingController();
    return GestureDetector(
      child: TextField(
        cursorColor: Colors.white,
        cursorHeight: 28,
        onTap: () {
          searchAppbarController.filterSearchingSongs('');
        },
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (value) {
          log(value);
          searchAppbarController.filterSearchingSongs(value);
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
                searchAppbarController.fetchAllSearchedSongs();
                searchAppbarController.isSearched.value = false;
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
                size: 26,
              )),
          focusColor: Colors.white,
          hintText: 'Search Here.....',
          hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
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
    );
  }
}
