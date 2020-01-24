import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'src/screens/top_news_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
          ),
          primaryColor: Colors.white,
        ),
        home: TopNews(),
      ),
    );
  }
}
