class Article {
  int? id;
  String name;
  String title;
  String author;
  String description;
  String? url;
  String urlToIamge;
  String? content;
  DateTime publishedAt;
  String category;

  Article({
    this.id,
    required this.name,
    required this.title,
    required this.author,
    required this.description,
     this.url,
    required this.urlToIamge,
    required this.publishedAt,
     this.content,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['title'] = title;
    map['author'] = author;
    map['description'] = description;
    map['url'] = url;
    map['urlToImage'] = urlToIamge;
    map['publishedAt'] = publishedAt.toString();
    map['content'] = content;
    map['category'] = category;

    return map;
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'],
      name: map['name'],
      title: map['title'],
      author: map['author'],
      description: map['description'],
      url: map['url'],
      urlToIamge: map['urlToImage'],
      publishedAt:DateTime.parse(map['publishedAt']) ,
      content: map['content'],
      category: map['category'],
    );
  }
}
