import 'dart:convert';

class TopStory {
  final List<String?> title;
  final List<String?> post;
  final List<String?> link;
  final List<String?> img;

  TopStory({
    required this.title,
    required this.post,
    required this.link,
    required this.img,
  });

  TopStory copyWith({
    List<String?>? title,
    List<String?>? post,
    List<String?>? link,
    List<String?>? img,
  }) {
    return TopStory(
      title: title ?? this.title,
      post: post ?? this.post,
      link: link ?? this.link,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'post': post,
      'link': link,
      'img': img,
    };
  }

  factory TopStory.fromMap(Map<String, dynamic> map) {
    return TopStory(
      title: List<String?>.from(map['title']),
      post: List<String?>.from(map['post']),
      link: List<String?>.from(map['link']),
      img: List<String?>.from(map['img']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TopStory.fromJson(String source) =>
      TopStory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TopStory(title: $title, post: $post, link: $link, img: $img)';
  }
}
