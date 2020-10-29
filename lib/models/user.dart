class User {
  int id;
  String first_name;
  String last_name;
  String mobile;
  String profile_pic;

  User({
    this.id,
    this.first_name,
    this.last_name,
    this.mobile,
    this.profile_pic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      mobile: json['mobile'],
      profile_pic: json['profile_pic'],
    );
  }

  dynamic toJson() => {
        'id': id,
        'first_name': first_name,
        'last_name': last_name,
        'mobile': mobile,
        'profile_pic': profile_pic,
      };
}
