import 'dart:async';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../helper/news.dart';
import '../model/article_model.dart';
import '../screens/articale_detail_screen.dart';
import '../widgets/category_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Article> _articleList;
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  String category = '';
  String? search;

  final TextEditingController _text = TextEditingController();

  int count = 0;
  bool _isloading = true;
  bool _isDataLoaded = false;

  _updateArticleList(String category, [String? search]) {
    
    Future<List<Article>> _articleListFuture =
        _databaseHelper.getArticleList(category, search);

    _articleListFuture.then((value) {
      setState(() {
        _articleList = value;
        count = value.length;
        _isloading = false;
       
      });
    });
  }

  getNews() async {
    

    News news = News();
    await news.getNews();
    setState(() {
      _isDataLoaded = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('bool', _isDataLoaded);

    
  }

  getAllSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? value = prefs.getBool('bool');
    if (value != null) {
      setState(() {
        _isDataLoaded = value;
        
      });
    }
  }

  _initilized() async {
    await getAllSavedData();
    

    if (!_isDataLoaded) {
      await getNews();
      _updateArticleList(category);
    } else {
      _updateArticleList(category);
    }
  }

  @override
  void initState() {
    _isloading = true;
    category = 'sports';

    super.initState();
    _initilized();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'News',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.menu,
                  size: 25.0,
                ))
          ],
          elevation: 0.0,
        ),
        body: SafeArea(
            child: _isloading
                ? const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  )
                : Container(
                    height: size.height,
                    width: size.width,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height / 2.8,
                          width: size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Hey',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.black45),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Discover Latest News',
                                style: TextStyle(
                                  fontSize: 36.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12, top: 8),
                                child: TextField(
                                  controller: _text,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      _updateArticleList(category);
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    }
                                    search = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Search for news',
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      suffixIcon: Container(
                                        color: Colors.red,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());

                                            _updateArticleList(
                                                category, search);
                                          },
                                        ),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            category = 'sports';
                                            _updateArticleList(category);
                                          });
                                        },
                                        child: CategoryWidget(
                                            categoryName: 'Sports',
                                            imageAssets: 'sports')),
                                    InkWell(
                                      onTap: () {
                                        category = 'business';
                                        _updateArticleList(category);
                                      },
                                      child: CategoryWidget(
                                          categoryName: 'Business',
                                          imageAssets: 'business'),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        category = 'entertainment';
                                        _updateArticleList(category);
                                      },
                                      child: CategoryWidget(
                                          categoryName: 'Entertainment',
                                          imageAssets: 'entertainment'),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        category = 'health';
                                        _updateArticleList(category);
                                      },
                                      child: CategoryWidget(
                                          categoryName: 'Health',
                                          imageAssets: 'health'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      color: Colors.red,
                                      width: 3,
                                      height: 20,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Text(
                                        'Breaking News',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        goToLIstView(size),
                      ],
                    ),
                  )));
  }

  Widget goToLIstView(Size size) {
    return _articleList.isEmpty
        ? const Center(
            child: Text(
              'NO DATA',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          )
        : Expanded(
            child: ListView.builder(
                itemCount: _articleList.length,
                itemBuilder: (BuildContext context, int position) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ArticaleDetailScreen(
                                    article: _articleList[position],
                                  )));
                    },
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: size.height / 6,
                              width: size.width / 3,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Image.network(
                                _articleList[position].urlToIamge,
                                height: size.height / 4,
                                width: size.height / 4,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: (size.width * 2) / 3.7,
                                child: Text(
                                  _articleList[position].title,
                                  maxLines: 4,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(DateFormat.yMMMMd()
                                  .format(_articleList[position].publishedAt)
                                  .toString()),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
  }
}
