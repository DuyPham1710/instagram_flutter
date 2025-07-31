class Routes {
  // Api paths for authentication
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh-token';
  static const String verifyAccount = '/auth/verify-account';
  static const String resendOtp = '/auth/resend-otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // Api paths for user
  static const String user = '/users';
  static const String userProfile = '/users/profile';
  static const String search = '/users/search';
  static const String allUsersOther = '/users/other';

  // Api paths for posts
  static const String getAllPostsByUser = '/post';
  static const String getAllPostsFollowing = '/post/following';

  // Api paths for follow
  static const String getFollowers = '/follow/get-followers';
  static const String getFollowing = '/follow/get-following';

  // Api paths for likes
  static const String likePost = '/like/toggle-like';

  // Api paths for save posts
  static const String savePost = '/save-post/toggle-save-post';
}
