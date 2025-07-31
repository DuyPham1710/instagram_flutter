import 'package:instagram_flutter/providers/Follow_provider.dart';
import 'package:instagram_flutter/providers/auth_provider.dart';
import 'package:instagram_flutter/providers/post_provider.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/repositories/auth_repository.dart';
import 'package:instagram_flutter/repositories/follow_repository.dart';
import 'package:instagram_flutter/repositories/like_repository.dart';
import 'package:instagram_flutter/repositories/post_repository.dart';
import 'package:instagram_flutter/repositories/user_repository.dart';
import 'package:instagram_flutter/services/api/auth_api_service.dart';
import 'package:instagram_flutter/services/api/follow_api_service.dart';
import 'package:instagram_flutter/services/api/like_api_service.dart';
import 'package:instagram_flutter/services/api/post_api_service.dart';
import 'package:instagram_flutter/services/api/save_post_api_service.dart';
import 'package:instagram_flutter/services/api/user_api_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(
    create: (_) => AuthProvider(
      repository: AuthRepository(authApiService: AuthApiService()),
    ),
  ),
  ChangeNotifierProvider(
    create: (_) => UserProvider(
      repository: UserRepository(userApiService: UserApiService()),
    ),
  ),
  ChangeNotifierProvider(
    create: (_) => PostProvider(
      postRepository: PostRepository(
        postApiService: PostApiService(),
        savePostApiService: SavePostApiService(),
      ),
      likeRepository: LikeRepository(likeApiService: LikeApiService()),
    ),
  ),
  ChangeNotifierProvider(
    create: (_) => FollowProvider(
      followRepository: FollowRepository(followApiService: FollowApiService()),
    ),
  ),
];
