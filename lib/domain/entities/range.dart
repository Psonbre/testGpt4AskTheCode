class Range {
  final int min;
  final int max;
  final String label;
  final String color;
  final String healthEffect;
  final String note;

  Range(
      {required this.min,
      required this.max,
      required this.label,
      required this.color,
      required this.healthEffect,
      required this.note});

  factory Range.fromJson(Map<String, dynamic> json) {
    return Range(
        min: json['min'].toInt(),
        max: json['max'].toInt(),
        label: json['label'].toString(),
        color: json['color'].toString(),
        healthEffect: json['health_effect'] ?? 'Aucune donnée disponible.',
        note: json['note'].toString());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Range &&
        other.min == min &&
        other.max == max &&
        other.label == label &&
        other.color == color &&
        other.healthEffect == healthEffect &&
        other.note == note;
  }

  @override
  int get hashCode => label.hashCode ^ label.hashCode;
}
