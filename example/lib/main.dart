import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:wordpress_widget/wordpress_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TabItem homePage = TabItem(
      "Aktuelles",
      Icon(PlatformIcons(context).home),
      const StartTab(),
    );
    TabItem eventPage = TabItem(
      "Berichte",
      Icon(PlatformIcons(context).collections),
      const PostsTab(),
    );
    List<TabItem> tabs = [homePage, eventPage];
    return WordPress(
      appTitle: "Example App",
      lightTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xfffcb900),
        brightness: Brightness.light,
        cupertinoOverrideTheme:
            const CupertinoThemeData(primaryColor: Color(0xfffcb900)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xfffcb900),
        colorScheme: const ColorScheme.dark(background: Colors.black),
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black),
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: Color(0xfffcb900),
          barBackgroundColor: Colors.black,
          primaryContrastingColor: Color(0xfffcb900),
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      tabs: tabs,
    );
  }
}
