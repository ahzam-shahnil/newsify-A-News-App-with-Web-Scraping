class SearchArticle {
/*
{
  "title": "‘Old world dying in blaze of splendour' Musk's tweet shocks fans with apocalyptic vision",
  "author": "David Atkins",
  "published_date": "2021-08-25 00:37:40",
  "published_date_precision": "full",
  "link": "https://www.express.co.uk/news/world/1481472/elon-musk-tesla-twitter-world-end-latest-news-ont",
  "clean_url": "express.co.uk",
  "summary": "Elon Musk sent fans into a frenzy after posting a tweet with the message 'old world dying in blaze of splendour.'  This tweet follows the Taliban takeover of Kabul and Afghanistan which has left thousands trying to flee the country.Elon Musk is the founder, CEO and product architect of Tesla.The self-made billionaire is considered one of the world's most powerful people, ranking 21st on Forbes' list in December 2016.However, this tweet is from a book on WWI which read in full: \"So gorgeous was t",
  "rights": "google.com",
  "rank": 548,
  "topic": "news",
  "country": "GB",
  "language": "en",
  "authors": [
    "David Atkins"
  ],
  "media": "https://cdn.images.express.co.uk/img/dynamic/78/750x445/1481472.jpg",
  "is_opinion": false,
  "twitter_account": null,
  "_score": 13.8855,
  "_id": "b08ebf3ec6f50bef64342476489dac7f"
} 
*/

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
