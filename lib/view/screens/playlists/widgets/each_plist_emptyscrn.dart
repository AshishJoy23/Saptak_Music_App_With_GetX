import 'package:flutter/material.dart';
import 'package:saptak_music_app/view/screens/playlists/widgets/each_plist_appbar.dart';

import '../../../widgets/empty_list_screen.dart';

class EachPlaylistEmptyScreen extends StatelessWidget {
  const EachPlaylistEmptyScreen({
    super.key,
    required this.playlistName,
  });

  final String playlistName;

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        EachPlaylistAppbarWidget(playlistName: playlistName),
        const Expanded(
          child: EmptyListScreenWidget(
              message: "You haven't added anything ! \nAdd What You Love.."),
        ),
      ],
    );
  }
}


