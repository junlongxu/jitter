class VideosModel {
  String total;
  List<VideosListItem> list;
  int pageNum;
  int pageSize;
  int size;
  String startRow;
  String endRow;
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

  VideosModel(
      {this.total,
      this.list,
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
      this.navigateLastPage});

  VideosModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = new List<VideosListItem>();
      json['list'].forEach((v) {
        list.add(new VideosListItem.fromJson(v));
      });
    }
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    size = json['size'];
    startRow = json['startRow'];
    endRow = json['endRow'];
    pages = json['pages'];
    prePage = json['prePage'];
    nextPage = json['nextPage'];
    isFirstPage = json['isFirstPage'];
    isLastPage = json['isLastPage'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    navigatePages = json['navigatePages'];
    navigatepageNums = json['navigatepageNums'].cast<int>();
    navigateFirstPage = json['navigateFirstPage'];
    navigateLastPage = json['navigateLastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
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

class VideosListItem {
  String publishTime;
  String author;
  int playNum;
  String headImage;
  String videoImg;
  int praiseNum;
  String videoId;
  bool videoSort;
  String authorId;
  String videoTitle;
  String videoSize;
  int commentNum;
  int isAttention;
  String videoIdcUrl;
  int isPraise;
  int videoTime;
  bool areSelf;

  VideosListItem(
      {this.publishTime,
      this.author,
      this.playNum,
      this.headImage,
      this.videoImg,
      this.praiseNum,
      this.videoId,
      this.videoSort,
      this.authorId,
      this.videoTitle,
      this.videoSize,
      this.commentNum,
      this.isAttention,
      this.videoIdcUrl,
      this.isPraise,
      this.videoTime,
      this.areSelf});

  VideosListItem.fromJson(Map<String, dynamic> json) {
    publishTime = json['publishTime'];
    author = json['author'];
    playNum = json['playNum'];
    headImage = json['headImage'];
    videoImg = json['videoImg'];
    praiseNum = json['praiseNum'];
    videoId = json['videoId'];
    videoSort = json['videoSort'];
    authorId = json['authorId'];
    videoTitle = json['videoTitle'];
    videoSize = json['videoSize'];
    commentNum = json['commentNum'];
    isAttention = json['isAttention'];
    videoIdcUrl = json['videoIdcUrl'];
    isPraise = json['isPraise'];
    videoTime = json['videoTime'];
    areSelf = json['areSelf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publishTime'] = this.publishTime;
    data['author'] = this.author;
    data['playNum'] = this.playNum;
    data['headImage'] = this.headImage;
    data['videoImg'] = this.videoImg;
    data['praiseNum'] = this.praiseNum;
    data['videoId'] = this.videoId;
    data['videoSort'] = this.videoSort;
    data['authorId'] = this.authorId;
    data['videoTitle'] = this.videoTitle;
    data['videoSize'] = this.videoSize;
    data['commentNum'] = this.commentNum;
    data['isAttention'] = this.isAttention;
    data['videoIdcUrl'] = this.videoIdcUrl;
    data['isPraise'] = this.isPraise;
    data['videoTime'] = this.videoTime;
    data['areSelf'] = this.areSelf;
    return data;
  }
}
