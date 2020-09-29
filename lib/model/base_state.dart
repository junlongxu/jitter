class BaseState {
  String code;
  dynamic data;
  String mgs;
  BaseState({this.code, this.data, this.mgs});
  factory BaseState.fromJson(Map<String, dynamic> json) {
    return BaseState(
      code: json['code'],
      data: json['data'],
      mgs: json['mgs'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['data'] = this.data;
    data['mgs'] = this.mgs;
    return data;
  }
}
