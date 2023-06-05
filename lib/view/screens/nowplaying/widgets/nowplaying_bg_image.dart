import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingBGWidget extends StatelessWidget {
  const NowPlayingBGWidget({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final heightDsp = MediaQuery.of(context).size.height;
    final widthDsp = MediaQuery.of(context).size.width;
    return SizedBox(
      height: heightDsp,
      width: widthDsp,
      child: QueryArtworkWidget(
        artworkFit: BoxFit.cover,
        id: int.parse(id),
        type: ArtworkType.AUDIO,
        artworkQuality: FilterQuality.high,
        size: 2000,
        quality: 100,
        artworkBorder: BorderRadius.circular(20),
        nullArtworkWidget: Container(
          width: widthDsp * 0.134,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/logo_foreground.png')),
          ),
          //child: Icon(Icons.abc),
        ),
      ),
    );
  }
}
