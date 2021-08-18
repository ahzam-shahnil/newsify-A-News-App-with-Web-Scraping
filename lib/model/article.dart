class Article {
  Article({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.sourceName,
  });

  String? author;

  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  String? sourceName;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: json["author"]?.toString(),
        title: json["title"]?.toString(),
        description: json["description"]?.toString(),
        url: json["url"]?.toString(),
        urlToImage: json["urlToImage"]?.toString(),
        publishedAt: json["publishedAt"]?.toString(),
        content: json["content"]?.toString(),
        sourceName: json["source"]["name"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "sourceName": sourceName,
        "author": author,
        "title": title,
        "id": title! + sourceName! + publishedAt!,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt,
        "content": content,
      };
}
