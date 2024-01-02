part of wordpress_widget;

class CachedImage extends StatelessWidget {
  final String url;
  final double? height;
  final double width;
  final BoxFit fit;

  const CachedImage(this.url,
      {this.height,
      required this.width,
      this.fit = BoxFit.fitWidth,
      super.key});

  @override
  Widget build(BuildContext context) {
    return url == ''
        ? const Placeholder()
        // ? Image.asset(
        //     'images/logo.png',
        //     width: width,
        //     fit: BoxFit.fitWidth,
        // )
        : CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: url,
            fit: fit,
            // placeholder: (_, __) => Image.asset(
            //   'images/logo.png',
            //   width: width,
            //   height: height,
            //   fit: BoxFit.fitWidth,
            // ),
            // errorWidget: (_, __, ___) => Image.asset(
            //   'images/logo.png',
            //   width: width,
            //   fit: BoxFit.fitWidth,
            // ),
          );
  }
}
