import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';

class ListViewWidget extends StatefulWidget {
  final List dataList;
  final Function callback;
  const ListViewWidget({Key key, this.dataList, this.callback})
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
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()
          ),
            itemCount: widget?.dataList?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  _listItem(item: widget?.dataList[index]),
                  _bottomNot(index)
                ],
              );
            }));
  }

  _bottomNot(int index) {
    if (index == widget?.dataList?.length - 1) {
      return Container(
        margin: EdgeInsets.only(bottom: 6),
        child: Text(
          '暂时没有更多了',
          style: smallTextStyle,
        ),
      );
    } else {
      return emptyWidget;
    }
  }

  _listItem({item}) => Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        constraints: BoxConstraints(minHeight: 60),
        child: widget?.callback(item: item),
      );
}
