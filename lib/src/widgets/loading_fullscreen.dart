part of wordpress_widget;

class LoadingFullscreen extends StatelessWidget {
  const LoadingFullscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlatformCircularProgressIndicator(),
    );
  }
}
