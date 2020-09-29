import 'package:flutter/material.dart';
import 'package:jitter/util/base.dart';
import 'package:jitter/widgets/loading_widget.dart';

// ignore: must_be_immutable
class ListViewWidget extends StatefulWidget {
  List dataList;
  final Function callbackItem;
  Function callbackScroll;
  ListViewWidget(
      {Key key, this.dataList, this.callbackItem, this.callbackScroll})
      : super(key: key);
  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> with Base {
  ScrollController scrollController = new ScrollController();
  bool bottomLoading = false;
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print(scrollController.position.pixels);
        print(scrollController.position.maxScrollExtent);
        print("当前滚动位置：${scrollController.offset}");
        widget.callbackScroll(_bottomLoading);
      }
    });
    super.initState();
  }

  void _bottomLoading() {
    setState(() {
      bottomLoading = !bottomLoading;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      // key: ValueKey<double>(widget.itemWidth),
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: widget.dataList.length + 1,
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          if (index == widget.dataList.length) {
            return bottomLoading
                ? LoadingWidget(
                    loadingType: LoadingType.ballSpin,
                    size: 30.0,
                  )
                : emptyWidget;
          } else {
            return Column(
              children: <Widget>[
                _listItem(item: widget?.dataList[index]),
              ],
            );
          }
        },
      ),
    );
  }

  _listItem({item}) => Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        constraints: BoxConstraints(minHeight: 60),
        child: widget?.callbackItem(item: item),
      );

  _bottomNot(int index) {
    if (index == widget.dataList.length - 1) {
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
}
