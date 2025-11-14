class ArticleModel {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage; 
  final String? content;

  ArticleModel({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['image'] as String?, 
      content: json['content'] as String?,
    );
  }
}