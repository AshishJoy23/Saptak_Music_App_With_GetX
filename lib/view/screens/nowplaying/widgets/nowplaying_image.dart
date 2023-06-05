import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingImageWidget extends StatelessWidget {
  const NowPlayingImageWidget({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final heightDsp = MediaQuery.of(context).size.height;
    final widthDsp = MediaQuery.of(context).size.width;
    return Container(
      height: heightDsp * 0.4,
      width: widthDsp * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
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
                image: AssetImage('assets/images/saptak_icon.png')),
          ),
        ),
      ),
    );
  }
}
