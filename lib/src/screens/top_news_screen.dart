import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/widgets/news_list_tile.dart';
import 'package:news/src/widgets/refresh.dart';

class TopNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StoriesBloc bloc = StoriesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Top news'),
        centerTitle: true,
      ),
      body: _buildList(bloc),
    );
  }

  Widget _buildList(bloc) {
    return StreamBuilder<List<int>>(
      stream: bloc.topIds$,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Refresh(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                int itemId = snapshot.data[index];
                bloc.addItem(itemId);
                return NewsListTile(
                  itemId: itemId,
                );
              },
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
