class ToggleFollowDto {
  final int followingId;

  ToggleFollowDto({required this.followingId});

  Map<String, dynamic> toJson() {
    return {'followingId': followingId};
  }

  factory ToggleFollowDto.fromJson(Map<String, dynamic> json) {
    return ToggleFollowDto(followingId: json['followingId']);
  }
}
