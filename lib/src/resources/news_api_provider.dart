import 'package:http/http.dart' show Client, Response;
import 'dart:convert';
import 'package:news/src/models/item_model.dart';
import 'source.dart';

class NewsApiProvider implements Source{
  final String _root = 'https://hacker-news.firebaseio.com';

  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final Response response = await client
        .get('https://hacker-news.firebaseio.com/v0/topstories.json');
    final List<dynamic> ids = jsonDecode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final Response response = await client.get('$_root/v0/item/$id.json');
    final parsedJson = jsonDecode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
