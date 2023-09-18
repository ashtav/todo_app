import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/app/data/services/local/storage.dart';

import 'app/core/constants/theme.dart';
import 'app/routes/routes.dart';

void main() async {
  // init flutter, to make sure all the widgets are ready
  WidgetsFlutterBinding.ensureInitialized();

  // init lazyui
  LazyUi.config(alwaysPortrait: true);

  // init shared preferences
  prefs = await SharedPreferences.getInstance();

  // init dio, we customize it with the name "fetchly"
  UseFetchly(
      baseUrl: 'https://api.igsa.pw/api/',
      onRequest: (status, data) {
        if (status == 401) {
          logg('unauthorized');
        }
      }).init();

  // check token
  String? token = prefs.getString('token');
  if (token != null) {
    UseFetchly().setToken(token);
  }

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
        builder: (BuildContext context, Widget? child) {
          return LazyUi.builder(context, child);
        });
  }
}
