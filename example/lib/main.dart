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
    TabItem homePage = TabItem(
      "Aktuelles",
      const Icon(Icons.home),
      const Placeholder(),
    );
    TabItem eventPage = TabItem(
      "Termine",
      const Icon(Icons.calendar_month),
      const Placeholder(),
    );
    List<TabItem> tabs = [homePage, eventPage];
    return WordPress(
      appTitle: "Example App",
      darkTheme: ThemeData.dark(),
      lightTheme: ThemeData.light(),
      tabs: tabs,
    );
  }
}
