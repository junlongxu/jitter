import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';

class ListViewWidget extends StatefulWidget {
  final List dataList;
  final Function callback;
  final double itemWidth;
  const ListViewWidget({Key key, this.dataList, this.callback, this.itemWidth})
      : super(key: key);
  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> with Base {
  @override
  Widget build(BuildContext context) {

    return Expanded(
        flex: 1,
        // key: ValueKey<double>(widget.itemWidth),
        child: ListView.builder(
            itemCount: widget?.dataList?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return _listItem(item: widget?.dataList[index]);
            }));
  }

  _listItem({item}) => Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        constraints: BoxConstraints(minHeight: 60),
        child: widget?.callback(item, widget?.itemWidth),
      );
}
