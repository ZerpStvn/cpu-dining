class UsersClass {
  String? uid;
  String? username;
  String? userschID;
  String? userdepartment;
  String? usercourse;
  String? useremail;
  String? userpassword;
  int? userrole;
  int? topup;
  UsersClass({
    this.topup,
    this.uid,
    this.username,
    this.userschID,
    this.userdepartment,
    this.usercourse,
    this.useremail,
    this.userpassword,
    this.userrole,
  });

  factory UsersClass.fromDucoments(map) {
    final dynamic topupValue = map['topup'];
    int? parsedTopup;

    if (topupValue is int) {
      parsedTopup = topupValue;
    } else if (topupValue is double) {
      parsedTopup = topupValue.toInt();
    }
    ;
    return UsersClass(
      topup: parsedTopup,
      uid: map['uid'],
      username: map['username'],
      userschID: map['userschID'],
      userdepartment: map['userdepartment'],
      usercourse: map['usercourse'],
      useremail: map['useremail'],
      userpassword: map['userpassword'],
      userrole: map['userrole'],
    );
  }

  Map<String, dynamic> tomap() {
    return {
      'uid': uid,
      'topup': 10000.0,
      'username': username,
      'userschID': userschID,
      'userdepartment': userdepartment,
      'usercourse': usercourse,
      'useremail': useremail,
      'userpassword': userpassword,
      'userrole': 0,
    };
  }
}
