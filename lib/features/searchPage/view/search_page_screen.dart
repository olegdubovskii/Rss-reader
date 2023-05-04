import 'package:flutter/material.dart';
import 'package:lab2rpo/services/news_model.dart';
import 'package:lab2rpo/services/parser_xml.dart';

class SearchPageScreen extends StatefulWidget {
  @override
  State<SearchPageScreen> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPageScreen> {
  void getNews(String url) async {
    ParserXML parser = ParserXML(url: url);
    List<NewsModel> news = await parser.getObjects();
    Navigator.pushReplacementNamed(context, 'homePage', arguments: {
      'news': news,
    });
  }

  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RSS-reader"),
      ),
      body: SafeArea(
        child: TextField(
          decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
          controller: urlController,
          keyboardType: TextInputType.url,
          onSubmitted: (value) {
            getNews(value);
          },
        ),
      ),
    );
  }
}