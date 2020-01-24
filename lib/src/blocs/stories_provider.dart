import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({Key key, this.child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  final Widget child;

  static StoriesBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StoriesProvider>().bloc;
  }

  @override
  bool updateShouldNotify(StoriesProvider oldWidget) {
    return true;
  }
}
