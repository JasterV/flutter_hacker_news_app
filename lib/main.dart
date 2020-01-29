import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_bloc.dart';
import 'package:news/src/blocs/comments_provider.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/screens/news_details.dart';
import 'src/screens/top_news_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: Colors.white,
            ),
            primaryColor: Colors.white,
          ),
          onGenerateRoute: router,
        ),
      ),
    );
  }

  Route router(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (BuildContext context) {
        final bloc = StoriesProvider.of(context);
        bloc.fetchTopIds();
        return TopNews();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        final itemId = int.parse(settings.name.substring(1));
        final bloc = CommentsProvider.of(context);
        bloc.fetchItemWithComments(itemId);
        return NewsDetail(
          itemId: itemId,
        );
      });
    }
  }
}
