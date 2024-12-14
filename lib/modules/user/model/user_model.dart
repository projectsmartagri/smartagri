class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? profileImageUrl;

  UserModel({this.uid, this.name, this.email, this.phone, this.profileImageUrl});

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
    };
  }

  // Convert JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}
