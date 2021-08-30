class TopStory {
  final String? title;
  final String? publishedAt;
  final String? url;
  final String? urlToImage;
  final String? sourceName;
  final String? content;
  final String? id;
  TopStory( {
    String? sourceName,
    required this.title,
    required this.publishedAt,
    required this.url,
    required this.urlToImage,
    String? content,
    this.id,
  })  : sourceName = sourceName ?? 'Web Desk',
        content = content ?? '';

  TopStory copyWith({
    String? title,
    String? publishedAt,
    String? url,
    String? urlToImage,
    String? content,
  }) {
    return TopStory(
      title: title ?? this.title,
      publishedAt: publishedAt ?? this.publishedAt,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'publishedAt': publishedAt,
      'url': url,
      'urlToImage': urlToImage,
      "id": id?? title! + sourceName!,
      'content': content,
    };
  }

  factory TopStory.fromJson(Map<String, dynamic> map) {
    return TopStory(
      title: map['title'],
      publishedAt: map['publishedAt'],
      url: map['url'],
      urlToImage: map['urlToImage'],
      content: map['content'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory TopStory.fromJson(String source) =>
  //     TopStory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TopStory(title: $title, publishedAt: $publishedAt, url: $url, urlToImage: $urlToImage, content: $content)';
  }
}
