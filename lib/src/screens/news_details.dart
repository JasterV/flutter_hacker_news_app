import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_bloc.dart';
import 'package:news/src/blocs/comments_provider.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  const NewsDetail({@required this.itemId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: _buildBody(bloc),
    );
  }

  Widget _buildBody(bloc) {
    return StreamBuilder<Map<int, Future<ItemModel>>>(
      stream: bloc.itemWithComments,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final itemsMap = snapshot.data;
        final itemFuture = itemsMap[itemId];
        return FutureBuilder<ItemModel>(
          future: itemFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final item = snapshot.data;
            return _buildList(item, itemsMap);
          },
        );
      },
    );
  }

  Widget _buildList(ItemModel item, Map<int, Future<ItemModel>> itemsMap) {
    final List<Widget> commentsList = item.kids.map((kidId) => Comment(
          id: kidId,
          itemsMap: itemsMap,
          depth: 0,
        )).toList();
        
    return ListView(
      children: [
        _buildTitle(item),
      ]..addAll(commentsList),
    );
  }

  Widget _buildTitle(ItemModel item) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      alignment: Alignment.topCenter,
      child: Card(
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            item.title,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
