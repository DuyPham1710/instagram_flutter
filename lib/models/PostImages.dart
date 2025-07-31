class PostImages {
  final int id;
  final String imageUrl;
  final String? caption;
  final int order;
  final DateTime createdAt;

  PostImages({
    required this.id,
    required this.imageUrl,
    this.caption,
    required this.order,
    required this.createdAt,
  });

  factory PostImages.fromJson(Map<String, dynamic> json) {
    return PostImages(
      id: json['id'],
      imageUrl: json['imageUrl'],
      caption: json['caption'],
      order: json['order'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'imageUrl': imageUrl,
    'caption': caption,
    'order': order,
    'createdAt': createdAt.toIso8601String(),
  };
}
