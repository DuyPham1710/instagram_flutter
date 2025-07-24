import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:instagram_flutter/screens/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(MyApp());
  runApp(MultiProvider(providers: appProviders, child: const MyApp()));
}
