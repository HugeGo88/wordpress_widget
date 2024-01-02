part of wordpress_widget;

class PostListItem extends StatelessWidget {
  final PostEntity post;

  const PostListItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
            context,
            platformPageRoute(
                builder: (context) => PostDetail(post), context: context));
      },
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: edgePadding),
                child: CachedImage(
                  post.image,
                  height: listHeight,
                  width: listWidth,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: contentPadding),
                      child: Text(
                        post.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.apply(fontWeightDelta: 1),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(edgePadding),
                child: Icon(
                  PlatformIcons(context).forward,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
