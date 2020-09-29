class UserInfo {
  String account;
  String age;
  bool areSelf;
  String area;
  bool attention;
  String balance;
  String birthday;
  String constellation;
  int fansNum;
  int focusNum;
  String goldNumber;
  String headImage;
  String id;
  bool isVip;
  String nickName;
  String praiseNum;
  String publicVideoNum;
  String remark;
  int sex;
  String userId;
  String videoPraiseNum;
  String vipTime;

  UserInfo(
      {this.account,
      this.age,
      this.areSelf,
      this.area,
      this.attention,
      this.balance,
      this.birthday,
      this.constellation,
      this.fansNum,
      this.focusNum,
      this.goldNumber,
      this.headImage,
      this.id,
      this.isVip,
      this.nickName,
      this.praiseNum,
      this.publicVideoNum,
      this.remark,
      this.sex,
      this.userId,
      this.videoPraiseNum,
      this.vipTime});

  UserInfo.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    age = json['age'];
    areSelf = json['areSelf'];
    area = json['area'];
    attention = json['attention'];
    balance = json['balance'];
    birthday = json['birthday'];
    constellation = json['constellation'];
    fansNum = json['fansNum'];
    focusNum = json['focusNum'];
    goldNumber = json['goldNumber'];
    headImage = json['headImage'];
    id = json['id'];
    isVip = json['isVip'];
    nickName = json['nickName'];
    praiseNum = json['praiseNum'];
    publicVideoNum = json['publicVideoNum'];
    remark = json['remark'];
    sex = json['sex'];
    userId = json['userId'];
    videoPraiseNum = json['videoPraiseNum'];
    vipTime = json['vipTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = this.account;
    data['age'] = this.age;
    data['areSelf'] = this.areSelf;
    data['area'] = this.area;
    data['attention'] = this.attention;
    data['balance'] = this.balance;
    data['birthday'] = this.birthday;
    data['constellation'] = this.constellation;
    data['fansNum'] = this.fansNum;
    data['focusNum'] = this.focusNum;
    data['goldNumber'] = this.goldNumber;
    data['headImage'] = this.headImage;
    data['id'] = this.id;
    data['isVip'] = this.isVip;
    data['nickName'] = this.nickName;
    data['praiseNum'] = this.praiseNum;
    data['publicVideoNum'] = this.publicVideoNum;
    data['remark'] = this.remark;
    data['sex'] = this.sex;
    data['userId'] = this.userId;
    data['videoPraiseNum'] = this.videoPraiseNum;
    data['vipTime'] = this.vipTime;
    return data;
  }
}
