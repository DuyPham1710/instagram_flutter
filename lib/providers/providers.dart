import 'package:instagram_flutter/providers/auth_provider.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/repositories/auth_repository.dart';
import 'package:instagram_flutter/repositories/user_repository.dart';
import 'package:instagram_flutter/services/api/auth_api_service.dart';
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
];
