part of wordpress_widget;

class WpApi {
  // static Future<List<PageEntity>> getPageList(
  //     {required String requestUrl}) async {
  //   List<PageEntity> pages = [];
  //   try {
  //     dynamic response = await http.get(Uri.parse(requestUrl));
  //     dynamic json = jsonDecode(response.body);
  //     for (var v in (json as List)) {
  //       pages.add(PageEntity.fromJson(v));
  //     }
  //   } catch (e) {
  //     //TODO do something
  //   }
  //   return pages;
  // }

  static Future<List<PostEntity>> getPostsList(
      {int category = 0, int page = 1, required String baseUrl}) async {
    List<PostEntity> posts = [];

    try {
      String extra = category != 0 ? '&categories=$category' : '';
      dynamic response =
          await http.get(Uri.parse('${baseUrl}posts?_embed&page=$page$extra'));
      dynamic json = jsonDecode(response.body);

      for (var v in (json as List)) {
        posts.add(PostEntity.fromJson(v));
      }
    } catch (e) {
      //TODO Handle No Internet Response
    }
    return posts;
  }

  static Future<List<EventEntity>> getEventList(
      {int category = 0, int page = 1}) async {
    List<EventEntity> events = [];
    try {
      String extra = category != 0 ? '&categories=$category' : '';
      var urll = '${url}wp-json/tribe/events/v1/events?_embed&page=$page$extra';
      dynamic response = await http.get(Uri.parse(urll));
      Map<String, dynamic> map = json.decode(response.body);
      dynamic data = map["events"];
      if (data != null) {
        for (var v in (data as List)) {
          events.add(EventEntity.fromJson(v));
        }
      }
    } catch (e) {
      //TODO Handle No Internet Response
    }
    return events;
  }

  static Future<List<TicketEntity>> getTicketList({int page = 1}) async {
    List<TicketEntity> tickets = [];
    try {
      var urll = '${url}wp-json/wp/v2/tribe_rsvp_tickets?page=$page';
      dynamic response = await http.get(Uri.parse(urll));
      dynamic json = jsonDecode(response.body);
      if (json != null) {
        for (var v in (json as List)) {
          tickets.add(TicketEntity.fromJson(v));
        }
      }
    } catch (e) {
      //TODO Handle No Internet Response
    }
    return tickets;
  }

  // static Future<List<NavigationItemEntitiy>> getNavigationItemList(
  //     {required int id}) async {
  //   List<NavigationItemEntitiy> navigationItmes = [];
  //   try {
  //     dynamic response = await http
  //         .get(Uri.parse('${url}wp-json/menus/v1/locations/main_nav/'));
  //     Map<String, dynamic> map = json.decode(response.body);
  //     //TODO this needs to be more robust
  //     dynamic itmes = map["items"];

  //     if (itmes != null) {
  //       for (var item in (itmes as List)) {
  //         if (id == item["ID"]) {
  //           var childItems = item["child_items"];
  //           for (var childItem in (childItems as List)) {
  //             navigationItmes.add(NavigationItemEntitiy.fromJson(childItem));
  //           }
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     //TODO do something
  //   }
  //   return navigationItmes;
  // }
}
