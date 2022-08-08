import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/helper/database_helper.dart';
import '../model/article_model.dart';

class News {
  Future<void> getNews() async {
    String apikey = '6d6b451cb499438aaee269261b8ba47d';
   
    var categories = ['sports', 'business', 'entertainment', 'health'];

    for (var category in categories) {
     
      Uri url = Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=$apikey");

      var response = await http.get(url);

      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == "ok") {
        jsonData['articles'].forEach((element) {
          if (element['source']['name'] != null &&
              element['title'] != null &&
              element['author'] != null &&
              element['description'] != null &&
              element['urlToImage'] != null &&
              element['publishedAt'] != null) {
            Article article = Article(
              name: element['source']['name'],
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToIamge: element['urlToImage'],
              publishedAt: DateTime.parse(element['publishedAt']),
              content: element['content'],
              category: category,
            );
            
            DatabaseHelper.instance.insertArticle(article);
          }
        });
      } 
    }

   
  }
}
