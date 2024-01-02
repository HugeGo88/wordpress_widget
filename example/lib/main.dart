import 'package:flutter/material.dart';
import 'package:wordpress_widget/wordpress_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WordPress(
      appTitle: "Example App",
      darkTheme: ThemeData.dark(),
      lightTheme: ThemeData.light(),
    );
  }
}
