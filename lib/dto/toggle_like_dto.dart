class ToggleLikeDto {
  final int postId;

  ToggleLikeDto({required this.postId});

  Map<String, dynamic> toJson() {
    return {'postId': postId};
  }

  factory ToggleLikeDto.fromJson(Map<String, dynamic> json) {
    return ToggleLikeDto(postId: json['postId']);
  }
}
