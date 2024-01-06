part of wordpress_widget;

class EventDetail extends StatefulWidget {
  final EventEntity event;
  const EventDetail(this.event, {super.key});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  Future<void> _onShare(context, EventEntity event) async {
    final box = context.findRenderObject() as RenderBox?;
    final urlImage = event.image;
    final url = Uri.parse(urlImage);
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(bytes);

    await Share.shareXFiles(
      [XFile(path)],
      text: event.url,
      subject: event.title,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    double imageHeight = widget.event.imageHeight.toDouble();
    double imageWidth = widget.event.imageWidth.toDouble();
    double? actualHeight;
    actualHeight =
        imageHeight * (MediaQuery.of(context).size.width / imageWidth);

    final controller1 = ScrollController();
    final controller2 = ScrollController();
    Size size = MediaQuery.of(context).size;
    initializeDateFormatting();
    return PlatformScaffold(
      iosContentPadding: true,
      appBar: PlatformAppBar(
        title: Text(
          widget.event.title,
        ),
        trailingActions: [
          Builder(
            builder: (context) {
              return PlatformIconButton(
                icon: Icon(PlatformIcons(context).share),
                onPressed: () async {
                  await analytics.logEvent(
                    name: "button_tracked",
                    parameters: {
                      "button_name": "ShareEvent",
                    },
                  );
                  _onShare(context, widget.event);
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Hero(
                          tag: widget.event.image,
                          child: CachedImage(
                            widget.event.image,
                            height: actualHeight,
                            width: size.width,
                          ),
                        ),
                        EventDetailData(widget.event),
                        HtmlContent(widget.event.description),
                      ],
                    ),
                  )
                : Row(
                    children: <Widget>[
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: controller1,
                        child: SizedBox(
                          width: size.width / 3,
                          child: Column(
                            children: <Widget>[
                              Hero(
                                tag: widget.event.image,
                                child: CachedImage(
                                  widget.event.image,
                                  width: size.width,
                                ),
                              ),
                              EventDetailData(widget.event),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: controller2,
                          physics: const BouncingScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width,
                                minHeight: MediaQuery.of(context).size.height),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  HtmlContent(widget.event.description),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
