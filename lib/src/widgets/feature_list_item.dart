part of wordpress_widget;

class FeatureListItem extends StatelessWidget {
  final PostEntity post;
  const FeatureListItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    double? imageHeight = post.extra.image?.first.height?.toDouble();
    double? imageWidth = post.extra.image?.first.width?.toDouble();
    double? actualHeight;
    if (imageHeight != null && imageWidth != null) {
      actualHeight =
          imageHeight * (MediaQuery.of(context).size.width / imageWidth);
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            platformPageRoute(
                builder: (context) => PostDetail(post), context: context));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: edgePadding * 2),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Hero(
                tag: post.image,
                child: CachedImage(
                  post.image,
                  width: MediaQuery.of(context).size.width,
                  // TODO make sure there will be no null
                  height: actualHeight,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff292929),
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: edgePadding, vertical: contentPadding),
                  child: Text(
                    post.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                height: 3,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
