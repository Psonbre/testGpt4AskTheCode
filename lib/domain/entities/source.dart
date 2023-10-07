class Source {
  final String name;
  final String url;
  final String img_path;

  Source({required this.name, required this.url, required this.img_path});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      name: json['name'].toString(),
      url: json['url'].toString(),
      img_path: json['img_path'].toString(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Source &&
        other.name == name &&
        other.url == url &&
        other.img_path == img_path;
  }

  @override
  int get hashCode => name.hashCode ^ name.hashCode;
}
