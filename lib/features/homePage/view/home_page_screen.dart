import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lab2rpo/services/news_model.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageScreen> {
  Map data = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    List<NewsModel> receivedModels = data['news'];
    if (receivedModels.isNotEmpty) {
      if (receivedModels[0].link=='') {
        return Scaffold(
          appBar: AppBar(
            title: Text("RSS-reader"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: IconButton(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, 'searchPage');
                    },
                    icon: Icon(
                      Icons.search_outlined,
                      size: 35,
                    )),
              )
            ],
          ),
          body: AlertDialog(
            content: Text("No internet connection",
            textAlign: TextAlign.center,)),
        );
      }
    }
  
    return Scaffold(
        appBar: AppBar(
          title: Text("RSS-reader"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: IconButton(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, 'searchPage');
                  },
                  icon: Icon(
                    Icons.search_outlined,
                    size: 35,
                  )),
            )
          ],
        ),
        body: GridView.builder(
            itemCount: receivedModels.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisExtent: 125,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  child: Row(children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: NetworkImage(receivedModels[index].enclosure),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          receivedModels[index].titel,
                          style: TextStyle(fontSize: 13),
                          softWrap: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          receivedModels[index].pubDate,
                          style: TextStyle(fontSize: 9),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(
                            context, 'aboutPage',
                            arguments: {'url': receivedModels[index].link});
                      },
                      icon: Icon(Icons.arrow_forward_ios_outlined)),
                )
              ]));
            }));
  }
}