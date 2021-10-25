import 'package:appcripto/config/app_settings.dart';
import 'package:appcripto/pages/home_page.dart';
import 'package:appcripto/repositories/conta_repositories.dart';
import 'package:appcripto/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContaRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppSettings(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritasRepositories(),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
        title: 'Moedabase',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
