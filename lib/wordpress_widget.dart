library wordpress_widget;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

part 'src/home_widget.dart';
part 'src/tab_item.dart';

final titles = ['Aktuelles', 'Termine', 'Berichte', 'Gruppen', 'Über'];

class WordPress extends StatefulWidget {
  final String appTitle;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final List<TabItem> tabs;

  const WordPress(
      {required this.appTitle,
      required this.darkTheme,
      required this.lightTheme,
      required this.tabs,
      super.key});

  @override
  State<WordPress> createState() => _WordPressState();
}

class _WordPressState extends State<WordPress> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.appTitle,
      theme: widget.lightTheme,
      darkTheme: widget.darkTheme,
      debugShowCheckedModeBanner: false,
      home: Material(
        child: PlatformTabScaffold(
          materialTabs: (_, __) =>
              MaterialNavBarData(type: BottomNavigationBarType.fixed),
          appBarBuilder: (_, index) => PlatformAppBar(
            title: Text(
              widget.tabs[index].title,
            ),
          ),
          tabController: tabController,
          items: items(context),
          bodyBuilder: (BuildContext context, int index) => ParentView(
            title: widget.tabs[index].title,
            child: ContentView(index: index, tabs: widget.tabs),
          ),
        ),
      ),
    );
  }

  items(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavigationBarItems =
        List.empty(growable: true);
    for (var tab in widget.tabs) {
      BottomNavigationBarItem bottomNavigationBarItem =
          BottomNavigationBarItem(icon: tab.icon, label: tab.title);
      bottomNavigationBarItems.add(bottomNavigationBarItem);
    }
    return bottomNavigationBarItems;
  }

  PlatformTabController tabController = PlatformTabController();
  @override
  void initState() {
    super.initState();
  }
}

@immutable
class ContentView extends StatefulWidget {
  final int index;
  final List<TabItem> tabs;

  const ContentView({super.key, required this.index, required this.tabs});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: trackPage(widget.index),
        builder: (context, snapshot) {
          return widget.tabs[widget.index].page;
        });
  }
}

Future<void> trackPage(int index) {
  try {
    return FirebaseAnalytics.instance.logEvent(
      name: "pages_tracked",
      parameters: {"page_name": titles[index], "page_index": index},
    );
  } on Exception catch (_) {
    return Future.delayed(const Duration(seconds: 0), () => 0);
  }
}

@immutable
class ParentView extends StatelessWidget {
  final String title;
  final Widget child;

  const ParentView({super.key, required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: child,
    );
  }
}
