import 'dart:convert';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String password;
  final String? shopName;
  final bool isMerchant;
  final String? imageUrl;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.password,
    this.shopName,
    required this.isMerchant,
    this.imageUrl,
  });

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? password,
    String? shopName,
    bool? isMerchant,
    String? imageUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      shopName: shopName ?? this.shopName,
      isMerchant: isMerchant ?? this.isMerchant,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'password': password,
      'shopName': shopName,
      'isMerchant': isMerchant,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      shopName: map['shopName'],
      isMerchant: map['isMerchant'] ?? false,
      imageUrl: map['imageUrl'],
    );
  }
  UserModel.fromSnapshot(snapshot)
      : uid = snapshot.data()['uid'],
        fullName = snapshot.data()['fullName'],
        email = snapshot.data()['email'],
        password = snapshot.data()['password'],
        shopName = snapshot.data()['shopName'],
        isMerchant = snapshot.data()['isMerchant'],
        imageUrl = snapshot.data()['imageUrl'];

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, fullName: $fullName, email: $email, password: $password, shopName: $shopName, isMerchant: $isMerchant, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.fullName == fullName &&
        other.email == email &&
        other.password == password &&
        other.shopName == shopName &&
        other.isMerchant == isMerchant &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        password.hashCode ^
        shopName.hashCode ^
        isMerchant.hashCode ^
        imageUrl.hashCode;
  }
}
