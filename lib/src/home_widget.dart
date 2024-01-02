part of wordpress_widget;

final titles = ['Aktuelles', 'Termine', 'Berichte', 'Gruppen', 'Über'];

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: PlatformTabScaffold(
        materialTabs: (_, __) =>
            MaterialNavBarData(type: BottomNavigationBarType.fixed),
        appBarBuilder: (_, index) => PlatformAppBar(
          title: Text(
            titles[index],
          ),
        ),
        tabController: tabController,
        items: items(context),
        bodyBuilder: (BuildContext context, int index) => ParentView(
          title: titles[index],
          child: ContentView(index: index),
        ),
      ),
    );
  }

  items(BuildContext context) => [
        BottomNavigationBarItem(
          label: titles[0],
          icon: Icon(PlatformIcons(context).home),
        ),
        BottomNavigationBarItem(
          label: titles[1],
          icon: const Icon(
            CupertinoIcons.calendar,
          ),
        ),
        BottomNavigationBarItem(
          label: titles[2],
          icon: Icon(PlatformIcons(context).collections),
        ),
        BottomNavigationBarItem(
          label: titles[3],
          icon: Icon(PlatformIcons(context).person),
        ),
        BottomNavigationBarItem(
          label: titles[4],
          icon: Icon(PlatformIcons(context).info),
        ),
      ];

  // This needs to be captured here in a stateful widget
  PlatformTabController tabController = PlatformTabController();
  @override
  void initState() {
    super.initState();
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

@immutable
class ContentView extends StatefulWidget {
  final int index;

  const ContentView({super.key, required this.index});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: trackPage(widget.index),
      builder: (context, snapshot) {
        switch (widget.index) {
          case 0:
            return const Placeholder();
          case 1:
            return const Placeholder();
          case 2:
            return const Placeholder();
          case 3:
            return const Placeholder();
          case 4:
            return const Placeholder();
          default:
            return const Placeholder();
        }
      },
    );
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
