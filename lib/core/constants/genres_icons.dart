import 'package:flutter/material.dart';

enum GenresIcons {
  action(28, Icons.local_fire_department),
  adventure(12, Icons.explore),
  animation(16, Icons.animation),
  comedy(35, Icons.sentiment_very_satisfied),
  crime(80, Icons.local_police),
  documentary(99, Icons.videocam),
  drama(18, Icons.theater_comedy),
  family(10751, Icons.family_restroom),
  fantasy(14, Icons.auto_awesome),
  history(36, Icons.history_edu),
  horror(27, Icons.nights_stay),
  music(10402, Icons.music_note),
  mystery(9648, Icons.search),
  romance(10749, Icons.favorite),
  scienceFiction(878, Icons.rocket_launch),
  tvMovie(10770, Icons.tv),
  thriller(53, Icons.bolt),
  war(10752, Icons.military_tech),
  western(37, Icons.landscape),

  actionAdventure(10759, Icons.local_fire_department),
  kids(10762, Icons.child_care),
  news(10763, Icons.newspaper),
  reality(10764, Icons.live_tv),
  sciFiFantasy(10765, Icons.rocket_launch),
  soap(10766, Icons.forum),
  talk(10767, Icons.mic),
  warPolitics(10768, Icons.gavel),

  unknown(0, Icons.local_movies);

  const GenresIcons(this.genreId, this.icon);

  final int genreId;
  final IconData icon;

  static IconData fromId(int id) {
    return GenresIcons.values
        .firstWhere((g) => g.genreId == id, orElse: () => GenresIcons.unknown)
        .icon;
  }
}
