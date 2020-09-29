import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';

class GridViewWidget extends StatefulWidget {
  final List gridList;
  final Function callback;
  final int count;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  const GridViewWidget(
      {Key key,
      this.gridList,
      this.callback,
      this.count = 3,
      this.mainAxisSpacing = 10.0,
      this.crossAxisSpacing = 10.0})
      : super(key: key);
  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> with Base {
  @override
  Widget build(BuildContext context) {
    return widget?.gridList?.length != 0
        ? GridView.count(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            crossAxisCount: widget?.count,
            mainAxisSpacing: widget?.mainAxisSpacing,
            crossAxisSpacing: widget?.crossAxisSpacing,
            childAspectRatio: 0.7,
            children: <Widget>[
              ...widget.gridList.map((item) => widget?.callback(item)),
            ],
          )
        : Center(
            child: Text(
              '没有更多了',
              style: skyGraySmallTextStyle,
            ),
          );
  }
}
