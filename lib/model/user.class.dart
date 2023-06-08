class UsersClass {
  String? uid;
  String? username;
  String? userschID;
  String? userdepartment;
  String? usercourse;
  String? useremail;
  String? userpassword;
  int? userrole;
  UsersClass({
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
    return UsersClass(
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
