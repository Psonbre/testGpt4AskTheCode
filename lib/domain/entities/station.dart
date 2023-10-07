

import 'package:revolvair/domain/entities/source.dart';

class Station {
  final int id;
  final String slug;
  final String name;
  final double lat;
  final double long;
  final int activate;
  final int userId;
  final int commentCount;
  final Source? source;

  Station(
      {required this.id,
      required this.slug,
      required this.name,
      required this.lat,
      required this.long,
      required this.activate,
      required this.userId,
      required this.commentCount,
      this.source});

  factory Station.fromJson(Map<String, dynamic> json) {
    Source? sourceData =
        json['source'] != null ? Source.fromJson(json['source']) : null;
    return Station(
        id: json['id'].toInt(),
        slug: json['slug'].toString(),
        name: json['name'].toString(),
        lat: json['lat'].toDouble(),
        long: json['long'].toDouble(),
        activate: json['activate'].toInt(),
        userId: json['user_id'].toInt(),
        commentCount: json['comment_count'].toInt(),
        source: sourceData);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Station &&
        other.id == id &&
        other.slug == slug &&
        other.name == name &&
        other.lat == lat &&
        other.long == long &&
        other.activate == activate &&
        other.userId == userId &&
        other.commentCount == commentCount &&
        other.source == source;
  }

  @override
  int get hashCode => id.hashCode ^ id.hashCode;
}
