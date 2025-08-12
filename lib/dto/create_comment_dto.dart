class CreateCommentDto {
  final String content;
  final int postId;

  CreateCommentDto({required this.content, required this.postId});

  Map<String, dynamic> toJson() {
    return {'content': content, 'postId': postId};
  }

  factory CreateCommentDto.fromJson(Map<String, dynamic> json) {
    return CreateCommentDto(content: json['content'], postId: json['postId']);
  }
}
