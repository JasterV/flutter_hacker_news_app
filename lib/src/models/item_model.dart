import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final int time;
  final String by;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'],
        time = parsedJson['time'],
        by = parsedJson['by'] ?? "",
        text = parsedJson['text'] ?? "",
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'],
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'],
        score = parsedJson['score'] ?? 0,
        title = parsedJson['title'],
        descendants = parsedJson['descendants'] ?? 0;

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] == 1,
        type = parsedJson['type'],
        time = parsedJson['time'],
        by = parsedJson['by'] ?? "",
        text = parsedJson['text'] ?? "",
        dead = parsedJson['dead'] == 1,
        parent = parsedJson['parent'],
        kids = jsonDecode(parsedJson['kids'].toString()) ?? [],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'] ?? 0;

  Map<String, dynamic> toMapForDb() {
    return {
      "id": id,
      "type": type,
      "time": time,
      "by": by,
      "text": text,
      "parent": parent,
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
      "deleted": deleted ? 1 : 0,
      "dead": dead ? 1 : 0,
      "kids": jsonEncode(kids),
    };
  }
}
