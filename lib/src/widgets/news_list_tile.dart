import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/loading_tile.dart';

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
          return LoadingTile();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
            if (!snapshot.hasData) {
              return LoadingTile();
            }
            return _buildTile(context, snapshot.data);
          },
        );
      },
    );
  }

  Widget _buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: <Widget>[
        Divider(
          height: 8.0,
        ),
        ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/${item.id}');
            },
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
}
