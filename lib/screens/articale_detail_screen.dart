import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/article_model.dart';

class ArticaleDetailScreen extends StatelessWidget {
  final Article? article;
  const ArticaleDetailScreen({this.article, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red,
                      child: Text(
                        article!.name[0],
                        style: const TextStyle(
                            color: Colors.white, fontSize: 28.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Container(
                        color: Colors.black,
                        width: 3,
                        height: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              DateFormat.yMMMMd()
                                  .format(article!.publishedAt)
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            article!.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  article!.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  article!.description,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.network(
                  article!.urlToIamge,
                )
              ],
            )),
      ),
    );
  }
}
