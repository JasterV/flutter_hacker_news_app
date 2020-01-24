import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/cache.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/resources/news_db_provider.dart';
import 'package:news/src/resources/source.dart';

class Repository {
  List<Source> sources = [
    dbProvider,
    NewsApiProvider(),
  ];
  List<Cache> caches = [
    dbProvider,
  ];

  Future<List<int>> fetchtopIds() async {
    return await sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        for (var cache in caches) 
          if (cache != source) cache.addItem(item);
        break;
      }
    }
    return item;
  }
}
