class ToggleSavePostDto {
  final int postId;

  ToggleSavePostDto({required this.postId});

  Map<String, dynamic> toJson() {
    return {'postId': postId};
  }

  factory ToggleSavePostDto.fromJson(Map<String, dynamic> json) {
    return ToggleSavePostDto(postId: json['postId']);
  }
}
