import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ListTileLeadingWidget extends StatelessWidget {
  final dynamic currentSong;
  const ListTileLeadingWidget({
    super.key,
    required this.currentSong,
  });

  @override
  Widget build(BuildContext context) {
    final widthDsp = MediaQuery.of(context).size.width;
    return QueryArtworkWidget(
      artworkFit: BoxFit.cover,
      id: currentSong.id!,
      type: ArtworkType.AUDIO,
      artworkQuality: FilterQuality.high,
      size: 2000,
      quality: 100,
      artworkBorder: BorderRadius.circular(10),
      nullArtworkWidget: Container(
        width: widthDsp * 0.134,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/saptak_icon.png')),
        ),
        //child: Icon(Icons.abc),
      ),
    );
  }
}
