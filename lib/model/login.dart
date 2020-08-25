class LoginModel {
  String token;
  String uid;
  String account;
  String nickName;
  String tel;
  String balance;
  String goldNumber;
  String area;
  String age;
  String constellation;
  String remark;
  int focusNum;
  int fansNum;
  String praiseNum;
  String adPlayTime;
  String viewNum;
  String viewTime;
  int sex;
  String headImage;

  LoginModel(
      {this.token,
      this.uid,
      this.account,
      this.nickName,
      this.tel,
      this.balance,
      this.goldNumber,
      this.area,
      this.age,
      this.constellation,
      this.remark,
      this.focusNum,
      this.fansNum,
      this.praiseNum,
      this.adPlayTime,
      this.viewNum,
      this.viewTime,
      this.sex,
      this.headImage});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    uid = json['uid'];
    account = json['account'];
    nickName = json['nickName'];
    tel = json['tel'];
    balance = json['balance'];
    goldNumber = json['goldNumber'];
    area = json['area'];
    age = json['age'];
    constellation = json['constellation'];
    remark = json['remark'];
    focusNum = json['focusNum'];
    fansNum = json['fansNum'];
    praiseNum = json['praiseNum'];
    adPlayTime = json['adPlayTime'];
    viewNum = json['viewNum'];
    viewTime = json['viewTime'];
    sex = json['sex'];
    headImage = json['headImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['uid'] = this.uid;
    data['account'] = this.account;
    data['nickName'] = this.nickName;
    data['tel'] = this.tel;
    data['balance'] = this.balance;
    data['goldNumber'] = this.goldNumber;
    data['area'] = this.area;
    data['age'] = this.age;
    data['constellation'] = this.constellation;
    data['remark'] = this.remark;
    data['focusNum'] = this.focusNum;
    data['fansNum'] = this.fansNum;
    data['praiseNum'] = this.praiseNum;
    data['adPlayTime'] = this.adPlayTime;
    data['viewNum'] = this.viewNum;
    data['viewTime'] = this.viewTime;
    data['sex'] = this.sex;
    data['headImage'] = this.headImage;
    return data;
  }
}
