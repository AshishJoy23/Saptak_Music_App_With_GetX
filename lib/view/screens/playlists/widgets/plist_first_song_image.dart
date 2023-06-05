import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistFirstSongImageWidget extends StatelessWidget {
  const PlaylistFirstSongImageWidget({
    super.key,
    required this.currentPlaylistSongs,
  });

  final List currentPlaylistSongs;

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: height1 * 0.35,
          width: width1,
          foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.9),
              ])),
          child: QueryArtworkWidget(
            artworkFit: BoxFit.fill,
            id: currentPlaylistSongs.first.id!,
            type: ArtworkType.AUDIO,
            artworkQuality: FilterQuality.high,
            size: 2000,
            quality: 100,
            artworkBorder: BorderRadius.circular(10),
            nullArtworkWidget: Container(
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/images/saptak_icon.png')),
              ),
            ),
          ),
        ),
        Positioned(
          top: height1 * 0.24,
          left: width1 * 0.39,
          child: Column(
            children: [
              Text(
                (currentPlaylistSongs.length <= 1)
                    ? '${currentPlaylistSongs.length.toString()} Song'
                    : '${currentPlaylistSongs.length.toString()} Songs',
                style: const TextStyle(fontSize: 23),
              ),
            ],
          ),
        )
      ],
    );
  }
}

