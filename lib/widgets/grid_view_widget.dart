import 'package:flutter/material.dart';

class GridViewWidget extends StatefulWidget {
  final List gridList;
  final Function callback;
  const GridViewWidget({Key key, this.gridList, this.callback})
      : super(key: key);
  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      crossAxisCount: 2,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      children: <Widget>[
        ...widget?.gridList.map((item) => widget?.callback(item))
      ],
    );
  }
}
