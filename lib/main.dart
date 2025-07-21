import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/repositories/auth_repository.dart';
import 'package:instagram_flutter/repositories/user_repository.dart';
import 'package:instagram_flutter/services/api/auth_api_service.dart';
import 'package:instagram_flutter/services/api/user_api_service.dart';
import 'package:provider/provider.dart';
import 'package:instagram_flutter/providers/auth_provider.dart';
import 'package:instagram_flutter/screens/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(MyApp());
  runApp(
    MultiProvider(
      providers: [
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
      ],
      child: const MyApp(),
    ),
  );
}
