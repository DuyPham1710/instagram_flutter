class ApiResponse {
  final int statusCode;
  final String message;
  final String timestamp;
  final String path;

  ApiResponse({
    required this.message,
    required this.statusCode,
    required this.timestamp,
    required this.path,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
      statusCode: json['statusCode'],
      timestamp: json['timestamp'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'statusCode': statusCode,
      'timestamp': timestamp,
      'path': path,
    };
  }
}
