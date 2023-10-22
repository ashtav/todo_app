import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/app/core/extensions/dio_extension.dart';
import 'package:todo_app/app/data/services/firebase/app_remote.dart';
import 'package:todo_app/app/data/services/local/storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/core/constants/theme.dart';
import 'app/data/api/api.dart';
import 'app/routes/routes.dart';

void main() async {
  // init flutter, to make sure all the widgets are ready
  WidgetsFlutterBinding.ensureInitialized();

  // init firebase
  await Firebase.initializeApp();

  // listen firebase app remote
  AppRemote.listen();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white));

  // init shared preferences
  prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  dio.setToken(token);

  // init provider and run app
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Todo App',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
