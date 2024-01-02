part of wordpress_widget;

class HtmlContent extends StatelessWidget {
  final String data;
  const HtmlContent(this.data, {super.key});

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(edgePadding),
        child: Material(
          child: Html(
            data: data,
            onLinkTap: (url, attributes, element) {
              var attributes = element?.attributes;
              if (attributes != null) {
                for (var entry in attributes.entries) {
                  var url = entry.value;
                  _launchInBrowser(Uri.parse(url));
                }
              }
            },
            style: {
              "blockquote": Style(
                margin: Margins(left: Margin(0)),
                padding: HtmlPaddings(left: HtmlPadding(edgePadding * 2)),
                fontStyle: FontStyle.italic,
                border: Border(
                  left: BorderSide(
                      color: Theme.of(context).primaryColor,
                      style: BorderStyle.solid,
                      width: 5.0),
                ),
              ),
              "a": Style(
                  textDecoration: TextDecoration.none,
                  color: Theme.of(context).primaryColor),
              "p": Style(textDecoration: TextDecoration.none),
              "li": Style(listStyleType: ListStyleType.square),
              "img": Style(
                width: Width(
                  MediaQuery.of(context).size.width - (3 * edgePadding),
                ),
              ),
            },
          ),
        ),
      ),
    );
  }
}
