import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:lab2rpo/features/homePage/home_page.dart';
import 'package:lab2rpo/features/aboutPage/about_page.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lab2rpo/features/searchPage/search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rss-Reader',
      initialRoute: 'searchPage',
      routes: {
        'homePage': (context) => HomePageScreen(),
        'aboutPage': (context) => AboutPageScreen(),
        'searchPage': (context) => SearchPageScreen(),
      },
    );
  }
}