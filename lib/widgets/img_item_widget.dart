import 'package:flutter/material.dart';
import 'package:jitter/model/videos.dart';
import 'package:jitter/util/NavigatorUtil.dart';
import 'package:jitter/views/player_item/index.dart';

class ImgItemWidget extends StatelessWidget {
  final String imgUrl;
  final Widget bottomChild;
  final Widget centerChild;
  const ImgItemWidget({
    @required this.imgUrl,
    this.bottomChild,
    this.centerChild,
  });
  @override
  Widget build(BuildContext context) {
    var item = {
      "publishTime": "2020-08-05 14:49:12",
      "author": "宰父天佑383",
      "playNum": 0,
      "headImage":
          "http://www.akixr.top:9000/bucket1-dev/IMAGES/2020080616/1290909944542998530/jpg/senba_empty_20200806154001_0.jpg",
      "videoImg":
          "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020080514/1290895585221619714/mp4/134.jpeg",
      "praiseNum": 7,
      "videoId": "1290902758332903426",
      "videoSort": false,
      "authorId": "1290909944542998530",
      "videoTitle": "爱是痛苦旳滋味",
      "videoSize": "8277719",
      "commentNum": 14,
      "isAttention": "0",
      "videoIdcUrl":
          "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020080514/1290895585221619714/mp4/134.mp4",
      "isPraise": "0",
      "videoTime": 37,
      "areSelf": false
    };
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
          onTap: () {
            NavigatorUtil.pushScale(
              context,
              Scaffold(
                // appBar: AppBar(
                //   elevation: 0,
                //   backgroundColor: Colors.white.withOpacity(0),
                // ),
                body: Stack(
                  children: <Widget>[
                    PlayerItem(
                      item: VideosListItem.fromJson(item),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 55, left: 15),
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop('true');
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
            );
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: 1000,
                // transform: Matrix4.compose(translation, rotation, scale),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imgUrl), fit: BoxFit.cover),
                ),
              ),
              Center(child: centerChild),
              bottomChild
            ],
          )),
    );
  }
}
