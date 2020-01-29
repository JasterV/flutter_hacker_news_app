import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/loading_tile.dart';

class Comment extends StatelessWidget {
  final int id;
  final Map<int, Future<ItemModel>> itemsMap;
  final int depth;

  const Comment({this.id, this.itemsMap, this.depth, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemsMap[id],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingTile();
        }
        final ItemModel item = snapshot.data;
        final children = <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0*(depth + 1), right: 16.0),
            title: _buildText(item),
            subtitle: item.by == ""
                ? Text("Deleted")
                : Text(item.by),
          ),
          Divider(),
        ];
        item.kids.forEach(
          (kidId) => children.add(
            Comment(
              id: kidId,
              itemsMap: itemsMap,
              depth: depth + 1,
            ),
          ),
        );
        return Column(
          children: children,
        );
      },
    );
  }

  Text _buildText(ItemModel item){
    final text = item.text
    .replaceAll('&#x27;', "'")
    .replaceAll("&quot;", '"')
    .replaceAll("<p>", "\n\n")
    .replaceAll("</p>", '')
    .replaceAll("<i>", "")
    .replaceAll("</i>", "")
    .replaceAll("&#x2F;", "/");
    return Text(text);

  }
}
