import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:dart_rss/domain/rss_enclosure.dart';
import 'news_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ParserXML {
  final String url;

  final String _no_image_url = "https://t3.ftcdn.net/jpg/04/34/72/82/240_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg";

  const ParserXML({required this.url});

  Future<List<NewsModel>> getObjects() async {
    List<NewsModel> Models = [];
    final inetCon = InternetConnectionChecker();
    bool isConnected = await inetCon.hasConnection;
    if (!isConnected) {
      Models.add(NewsModel(author: '', titel: '', link: '', enclosure: '', pubDate: ''));
      return Models;
    }
    try{
      final client = RetryClient(http.Client());
      await client.get(Uri.parse(url)).then((response) {
        return response.body;
      }).then((bodyString) {
        final channel = RssFeed.parse(bodyString);
        channel.items.forEach((item) {
          Models.add(NewsModel(
              author: item.author.toString(),
              titel: item.title.toString(),
              link: item.link.toString(),
              enclosure: _checkNotNullUrl(item.enclosure).url.toString() == ""
                  ? _no_image_url
                  : _checkNotNullUrl(item.enclosure).url.toString(),
              pubDate: item.pubDate.toString()));
        });
        return channel;
      });
    } catch (error) {
      return Models;
    }
    return Models;
  }

  dynamic _checkNotNullUrl(dynamic obj) {
    if (obj != null)
      return obj;
    else
      return RssEnclosure("", "", 0);
  }
}