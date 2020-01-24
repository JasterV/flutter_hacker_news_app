import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test("FetchTopIds returns a list of ids", () async {
    final NewsApiProvider newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      String responseBody = jsonEncode([1, 2, 3, 4, 5]);
      int statusCode = 200;
      return Response(responseBody, statusCode);
    });

    final List<int> ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4, 5]);
  });

  test("FetchItem returns an ItemModel", () async {
    final NewsApiProvider newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      String responseBody = jsonEncode(
        {"id": 4},
      );
      int statusCode = 200;
      return Response(responseBody, statusCode);
    });

    final item = await newsApi.fetchItem(999);

    expect(item.id, 4);
  });
}
