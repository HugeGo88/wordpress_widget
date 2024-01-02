library wordpress_widget;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

part 'src/home_widget.dart';

class WordPress extends StatelessWidget {
  final String appTitle;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const WordPress(
      {required this.appTitle,
      required this.darkTheme,
      required this.lightTheme,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeWidget(),
    );
  }
}
