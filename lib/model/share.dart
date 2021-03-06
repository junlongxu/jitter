class RootShare {
  String total;
  int pageNum;
  int pageSize;
  int size;
  int startRow;
  int endRow;
  int pages;
  int prePage;
  int nextPage;
  bool isFirstPage;
  bool isLastPage;
  bool hasPreviousPage;
  bool hasNextPage;
  int navigatePages;
  List<int> navigatepageNums;
  int navigateFirstPage;
  int navigateLastPage;
  List<ParetShare> list;

  RootShare(
      {this.total,
      this.pageNum,
      this.pageSize,
      this.size,
      this.startRow,
      this.endRow,
      this.pages,
      this.prePage,
      this.nextPage,
      this.isFirstPage,
      this.isLastPage,
      this.hasPreviousPage,
      this.hasNextPage,
      this.navigatePages,
      this.navigatepageNums,
      this.navigateFirstPage,
      this.navigateLastPage,
      this.list});

  factory RootShare.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    List<ParetShare> paretShareList;
    if (list.length != 0) {
      paretShareList = list.map((item) {
        return ParetShare.fromJson(item);
      }).toList();
    }

    return RootShare(
        total: json['total'],
        pageNum: json['pageNum'],
        pageSize: json['pageSize'],
        size: json['size'],
        startRow: json['startRow'],
        endRow: json['endRow'],
        pages: json['pages'],
        prePage: json['prePage'],
        nextPage: json['nextPage'],
        isFirstPage: json['isFirstPage'],
        isLastPage: json['isLastPage'],
        hasPreviousPage: json['hasPreviousPage'],
        hasNextPage: json['hasNextPage'],
        navigatePages: json['navigatePages'],
        navigatepageNums: json['navigatepageNums'].cast<int>(),
        navigateFirstPage: json['navigateFirstPage'],
        navigateLastPage: json['navigateLastPage'],
        list: paretShareList ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['pageNum'] = this.pageNum;
    data['pageSize'] = this.pageSize;
    data['size'] = this.size;
    data['startRow'] = this.startRow;
    data['endRow'] = this.endRow;
    data['pages'] = this.pages;
    data['prePage'] = this.prePage;
    data['nextPage'] = this.nextPage;
    data['isFirstPage'] = this.isFirstPage;
    data['isLastPage'] = this.isLastPage;
    data['hasPreviousPage'] = this.hasPreviousPage;
    data['hasNextPage'] = this.hasNextPage;
    data['navigatePages'] = this.navigatePages;
    data['navigatepageNums'] = this.navigatepageNums;
    data['navigateFirstPage'] = this.navigateFirstPage;
    data['navigateLastPage'] = this.navigateLastPage;
    return data;
  }
}

// 第一层评论
class ParetShare {
  String id;
  String parentId;
  String headImg;
  String userId;
  String nickname;
  String content;
  String commentDate;
  String praiseNum;
  String replyNum;
  String videoId;
  String commentId;
  int isPraise;
  List<ChildShare> child;

  ParetShare(
      {this.id,
      this.parentId,
      this.headImg,
      this.userId,
      this.nickname,
      this.content,
      this.commentDate,
      this.praiseNum,
      this.replyNum,
      this.videoId,
      this.commentId,
      this.isPraise,
      this.child});

  factory ParetShare.fromJson(Map<String, dynamic> json) {
    var paretShareChild = json['child'] as List;
    List<ChildShare> childList;
    if (paretShareChild.length != 0) {
      childList = paretShareChild.map((item) {
        return ChildShare.fromJson(item);
      }).toList();
    }
    return ParetShare(
      id: json['id'],
      parentId: json['parentId'],
      headImg: json['headImg'],
      userId: json['userId'],
      nickname: json['nickname'],
      content: json['content'],
      commentDate: json['commentDate'],
      praiseNum: json['praiseNum'],
      replyNum: json['replyNum'],
      videoId: json['videoId'],
      commentId: json['commentId'],
      isPraise: json['isPraise'],
      child: childList ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    data['headImg'] = this.headImg;
    data['userId'] = this.userId;
    data['nickname'] = this.nickname;
    data['content'] = this.content;
    data['commentDate'] = this.commentDate;
    data['praiseNum'] = this.praiseNum;
    data['replyNum'] = this.replyNum;
    data['videoId'] = this.videoId;
    data['commentId'] = this.commentId;
    data['isPraise'] = this.isPraise;
    return data;
  }
}

// 第二层
class ChildShare {
  final String id;
  final String parentId;
  final String headImg;
  final String userId;
  final String nickname;
  final String content;
  final String commentDate;
  final String praiseNum;
  final String toReplyUserId;
  final String toReplyUserImg;
  final String toReplyUserName;
  final String commentId;
  final int isPraise;
  final child;

  ChildShare(
      {this.id,
      this.parentId,
      this.headImg,
      this.userId,
      this.nickname,
      this.content,
      this.commentDate,
      this.praiseNum,
      this.toReplyUserId,
      this.toReplyUserImg,
      this.toReplyUserName,
      this.commentId,
      this.isPraise,
      this.child});

  factory ChildShare.fromJson(Map<String, dynamic> json) {
    return ChildShare(
      id: json['id'],
      parentId: json['parentId'],
      headImg: json['headImg'],
      userId: json['userId'],
      nickname: json['nickname'],
      content: json['content'],
      commentDate: json['commentDate'],
      praiseNum: json['praiseNum'],
      toReplyUserId: json['toReplyUserId'],
      toReplyUserImg: json['toReplyUserImg'],
      toReplyUserName: json['toReplyUserName'],
      commentId: json['commentId'],
      isPraise: json['isPraise'],
      child: json['child'] ?? null
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    data['headImg'] = this.headImg;
    data['userId'] = this.userId;
    data['nickname'] = this.nickname;
    data['content'] = this.content;
    data['commentDate'] = this.commentDate;
    data['praiseNum'] = this.praiseNum;
    data['toReplyUserId'] = this.toReplyUserId;
    data['toReplyUserImg'] = this.toReplyUserImg;
    data['toReplyUserName'] = this.toReplyUserName;
    data['commentId'] = this.commentId;
    data['isPraise'] = this.isPraise;
    return data;
  }
}
