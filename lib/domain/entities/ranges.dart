import 'package:flutter/foundation.dart';
import 'package:revolvair/domain/entities/range.dart';

class Ranges {
  final String name;
  final String source;
  final String url;
  final List<Range> ranges;
  
  Ranges(
      {required this.name,
      required this.source,
      required this.url,
      required this.ranges});

  factory Ranges.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? jsonRanges = json['ranges'] as List<dynamic>?;

    List<Range> tempList = [];

    if (jsonRanges != null) {
      for (var jsonRange in jsonRanges) {
        tempList.add(Range.fromJson(jsonRange));
      }
    }

    return Ranges(
        name: json['name'].toString(),
        source: json['source'].toString(),
        url: json['url'].toString(),
        ranges: tempList);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Ranges &&
        other.name == name &&
        other.source == source &&
        other.url == url &&
        listEquals(other.ranges, ranges);
  }

  @override
  int get hashCode {
    return Object.hash(name, source, url, ranges.hashCode);
  }
}
