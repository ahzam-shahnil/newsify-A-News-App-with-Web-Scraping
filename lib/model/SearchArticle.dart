class SearchArticle {

  String? title;
  String? author;
  String? publishedDate;

  String? link;

  String? summary;
  String? media;
  String? id;

  SearchArticle({
    this.title,
    this.author,
    this.publishedDate,
    this.link,
    this.summary,
    this.media,
    this.id,
  });
  SearchArticle.fromJson(Map<String, dynamic> json) {
    title = json["title"]?.toString();
    author = json["author"]?.toString();
    publishedDate = json["published_date"]?.toString();
    link = json["link"]?.toString();
    summary = json["summary"]?.toString();
    media = json["media"]?.toString();
    id = json["_id"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["title"] = title;
    data["author"] = author;
    data["published_date"] = publishedDate;
    data["link"] = link;
    data["summary"] = summary;
    data["media"] = media;
    data["_id"] = id;
    return data;
  }
}
