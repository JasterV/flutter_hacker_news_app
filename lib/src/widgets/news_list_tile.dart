import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/models/item_model.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({@required this.itemId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StoriesBloc bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items$,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return _loadingTile();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
            if (!snapshot.hasData) {
              return _loadingTile();
            }
            return _buildTile(snapshot.data);
          },
        );
      },
    );
  }

  Widget _buildTile(ItemModel item) {
    return Column(
      children: <Widget>[
        Divider(
          height: 8.0,
        ),
        ListTile(
            title: Text(item.title),
            subtitle: Text("Votes: ${item.score}"),
            trailing: Column(
              children: <Widget>[
                Icon(Icons.comment),
                Text("${item.descendants}")
              ],
            )),
      ],
    );
  }

  Widget _loadingTile() {
    return Column(
      children: <Widget>[
        Divider(
          height: 8.0,
        ),
        ListTile(
          title: Container(
            width: 150.0,
            height: 24.0,
            margin: EdgeInsets.only(top: 8.0, right: 5.0),
            color: Colors.grey[200],
          ),
          subtitle: Container(
            width: 150.0,
            height: 24.0,
            margin: EdgeInsets.only(top: 8.0, right: 5.0),
            color: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}
