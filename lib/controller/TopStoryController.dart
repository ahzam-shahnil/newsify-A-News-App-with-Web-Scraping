// import 'package:get/get.dart';
// import 'package:html/dom.dart' as dom;
// import 'package:html/parser.dart' as parser;
// import 'package:logger/logger.dart';

// import 'package:http/http.dart' as http;
// import 'package:newsify/config/constant.dart';
// import 'package:newsify/model/article.dart';
// import 'package:newsify/model/top_story.dart';

// class DetailArticleController extends GetxController {
//   String title = '';
//   String? publishedAt = '';
//   String? sourceName = '';
//   String? link = '';
//   String? img = '';
//   Logger logger = Logger();
//   var articlesList = <Article>[].obs;

//   // @override
//   // void onInit() {
//   //   // _getData();
//   //   super.onInit();
//   // }

//   Future<void> getData() async {
//     for (var i = 0; i < articlesList.length; i++) {
//       try {
//         articlesList[i] = (await getArticle(path: kGeoPath[i]));
//         logger.i(articlesList[i][0].urlToImage);
//         Future.delayed(Duration(seconds: 3));
//       } catch (e) {
//         //? IT IS ADDED TEMPORARILY
//         logger.e(e);
//       }
//     }
//   }

//   Future<List<TopStory>> getArticle({required String path}) async {
//     List<TopStory>? topList = <TopStory>[];
//     title = '';
//     link = '';
//     img = '';
//     publishedAt = '';
//     final response = await http.get(Uri.parse(
//       '$path',
//     ));
//     dom.Document document = parser.parse(response.body);
//     final elements = document.getElementsByClassName('list');
//     final sourceElement = document.getElementsByClassName('author_agency');
//     final element2 = document.getElementsByClassName('entry-content-heading');

//     final imgElement = document.getElementsByClassName('pic');

//     title = imgElement.map((element) =>
//         element.getElementsByTagName('img')[0].attributes['title']);
//     sourceName = sourceElement.first.innerHtml;

//     publishedAt = element2
//         .map((element) => element
//             .getElementsByClassName("entry-title")[0]
//             .getElementsByTagName('span')[0]
//             .innerHtml)
//         .toList();
//     link = elements
//         .map((element) => element
//             .getElementsByTagName("ul")[0]
//             .getElementsByTagName('li')[0]
//             .getElementsByTagName('a')[0]
//             .attributes['href'])
//         .toList();
//     if (path.contains('news')) {
//       img = imgElement
//           .map((element) =>
//               element.getElementsByTagName('img')[0].attributes['data-src'])
//           .toList();
//     }

// //? Geo news website uses data src attribute in some pages and in some they use src attribute
// //? to make sure that our image list is not empty . If it is empty the it means that the page requires
// //? src attribute to get img data
//     else {
//       img = imgElement
//           .map((element) =>
//               element.getElementsByTagName('img')[0].attributes['src'])
//           .toList();
//     }
// //? To make Top Story by using for loop to iterate throught different maps at the same time
//     for (var i = 0; i < title.length; i++) {
//       if (i < title.length &&
//           i < img.length &&
//           i < link.length &&
//           i < publishedAt.length) {
//         topList.add(TopStory(
//           title: title[i],
//           publishedAt: publishedAt[i],
//           url: link[i],
//           urlToImage: img[i],
//         ));
//       }
//     }
//     return topList;
//   }
// }
