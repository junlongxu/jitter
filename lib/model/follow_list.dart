class FollowFans {
  String total;
  List<FollowFansListItem> list;
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

  FollowFans(
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

  FollowFans.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = new List<FollowFansListItem>();
      json['list'].forEach((v) {
        list.add(FollowFansListItem.fromJson(v));
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

class FollowFansListItem {
  String id;
  String userId;
  String followUserId;
  String createTime;
  String createUser;
  Null updateTime;
  String updateUser;
  String headImage;
  String remark;
  int fansNum;
  String constellation;
  String birthday;
  String area;
  String focusNum;
  String praiseNum;
  String nickName;
  bool areSelf;
  String sex;
  String age;
  String videoPraiseNum;
  String publicVideoNum;
  bool attention;

  FollowFansListItem(
      {this.id,
      this.userId,
      this.followUserId,
      this.createTime,
      this.createUser,
      this.updateTime,
      this.updateUser,
      this.headImage,
      this.remark,
      this.fansNum,
      this.constellation,
      this.birthday,
      this.area,
      this.focusNum,
      this.praiseNum,
      this.nickName,
      this.areSelf,
      this.sex,
      this.age,
      this.videoPraiseNum,
      this.publicVideoNum,
      this.attention});

  FollowFansListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    followUserId = json['followUserId'];
    createTime = json['createTime'];
    createUser = json['createUser'];
    updateTime = json['updateTime'];
    updateUser = json['updateUser'];
    headImage = json['headImage'];
    remark = json['remark'];
    fansNum = json['fansNum'];
    constellation = json['constellation'];
    birthday = json['birthday'];
    area = json['area'];
    focusNum = json['focusNum'];
    praiseNum = json['praiseNum'];
    nickName = json['nickName'];
    areSelf = json['areSelf'];
    sex = json['sex'];
    age = json['age'];
    videoPraiseNum = json['videoPraiseNum'];
    publicVideoNum = json['publicVideoNum'];
    attention = json['attention'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['followUserId'] = this.followUserId;
    data['createTime'] = this.createTime;
    data['createUser'] = this.createUser;
    data['updateTime'] = this.updateTime;
    data['updateUser'] = this.updateUser;
    data['headImage'] = this.headImage;
    data['remark'] = this.remark;
    data['fansNum'] = this.fansNum;
    data['constellation'] = this.constellation;
    data['birthday'] = this.birthday;
    data['area'] = this.area;
    data['focusNum'] = this.focusNum;
    data['praiseNum'] = this.praiseNum;
    data['nickName'] = this.nickName;
    data['areSelf'] = this.areSelf;
    data['sex'] = this.sex;
    data['age'] = this.age;
    data['videoPraiseNum'] = this.videoPraiseNum;
    data['publicVideoNum'] = this.publicVideoNum;
    data['attention'] = this.attention;
    return data;
  }
}
