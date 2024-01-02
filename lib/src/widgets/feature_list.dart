part of wordpress_widget;

class FeatureList extends StatefulWidget {
  const FeatureList({super.key});

  @override
  State<FeatureList> createState() => _FeatureListState();
}

class _FeatureListState extends State<FeatureList> {
  List<PostEntity> allPosts = <PostEntity>[];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    WpApi.getPostsList(category: featuredCategoryId, baseUrl: baseUrl).then(
      (posts) {
        setState(
          () {
            isLoading = false;
            allPosts.addAll(posts);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingFullscreen()
        : ListView.builder(
            itemCount: allPosts.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => FeatureListItem(allPosts[index]),
          );
  }
}
