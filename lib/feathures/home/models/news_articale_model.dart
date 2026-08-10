class NewsArticaleModel {
  NewsArticaleModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final String? author;
  final String title;

  final String? description;

  final String? url;

  final String urlToImage;

  final String? publishedAt;

  final String? content;

  Map<String, dynamic> toJson() {
    return {
      "author": author,
      "title": title,
      "description": description,
      "url": url,
      "urlToImage": urlToImage,
      "publishedAt": publishedAt,
      "content": content,
    };
  }

  factory NewsArticaleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticaleModel(
      author: json['author'] ?? "",
      title: json['title'] ?? "",
      description: json["description"] ?? "",
      url: json["url"],
      urlToImage: json["urlToImage"] ?? "",
      publishedAt: json["publishedAt"],
      content: json["content"] ?? "",
    );
  }
}
