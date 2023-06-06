import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/search_controller.dart';

class RecentSearchClearButton extends StatelessWidget {
  const RecentSearchClearButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SearchController searchClearController = Get.put(SearchController());
    return TextButton(
      style: ButtonStyle(
        overlayColor:
            MaterialStateProperty.all<Color>(Colors.white60.withOpacity(0.1)),
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
                searchClearController.clearSearchedSongs();
                Get.back();
                Get.snackbar(
                  'Recent Searches',
                  'Cleared your Search History',
                  colorText: Colors.black,
                  duration: const Duration(milliseconds: 1500),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.grey,
                  reverseAnimationCurve: Curves.easeOut,
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
            style: TextStyle(fontSize: 16, color: Colors.white60),
          ),
          Icon(
            Icons.clear_all,
            size: 30,
            color: Colors.white60,
          ),
        ],
      ),
    );
  }
}
