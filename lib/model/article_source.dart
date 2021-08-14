class ArticleSource {
  ArticleSource({
    this.id,
    required this.name,
  });

  String? id;
  String name;

  factory ArticleSource.fromJson(Map<String, dynamic> json) => ArticleSource(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name,
      };
}
