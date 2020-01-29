import 'package:flutter/material.dart';

class LoadingTile extends StatelessWidget {
  const LoadingTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
