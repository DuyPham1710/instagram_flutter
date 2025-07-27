class Post {
  final int postId;
  final String contentUrl;
  final String? caption;
  //final int userId; // Hoặc kiểu User nếu muốn nested
  final DateTime createdAt;

  Post({
    required this.postId,
    required this.contentUrl,
    this.caption,
    // required this.userId,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      contentUrl: json['contentUrl'],
      caption: json['caption'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'contentUrl': contentUrl,
      'caption': caption,
      //  'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
