import 'package:flutter/material.dart';

class GridViewWidget extends StatefulWidget {
  final List gridList;

  const GridViewWidget({Key key, this.gridList}):super(key: key);
  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
      children: <Widget>[
        ..._item()
      ],
    );
  }

  List<GestureDetector> _item() {
    return widget?.gridList.map((item) => GestureDetector(
      onTap: () {},
      child: Container(
        width: 200,
        height: 250,
        color: Colors.red,
        child: Stack(
          children: <Widget>[
            Image.network(item)
          ],
        ),
      ),
    )).toList();
  }
}
