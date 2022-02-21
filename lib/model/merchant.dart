// import 'dart:convert';

// class Merchant {
//   final String uid;
//   final String fullName;
//   final String shopName;
//   final String email;
//   final String password;
//   final String? imageUrl;
//   Merchant({
//     required this.uid,
//     required this.fullName,
//     required this.shopName,
//     required this.email,
//     required this.password,
//     this.imageUrl,
//   });

//   Merchant copyWith({
//     String? uid,
//     String? fullName,
//     String? shopName,
//     String? email,
//     String? password,
//     String? imageUrl,
//   }) {
//     return Merchant(
//       uid: uid ?? this.uid,
//       fullName: fullName ?? this.fullName,
//       shopName: shopName ?? this.shopName,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       imageUrl: imageUrl ?? this.imageUrl,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'fullName': fullName,
//       'shopName': shopName,
//       'email': email,
//       'password': password,
//       'imageUrl': imageUrl,
//     };
//   }

//   factory Merchant.fromMap(Map<String, dynamic> map) {
//     return Merchant(
//       uid: map['uid'] ?? '',
//       fullName: map['fullName'] ?? '',
//       shopName: map['shopName'] ?? '',
//       email: map['email'] ?? '',
//       password: map['password'] ?? '',
//       imageUrl: map['imageUrl'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Merchant.fromJson(String source) =>
//       Merchant.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Merchant(uid: $uid, fullName: $fullName, shopName: $shopName, email: $email, password: $password, imageUrl: $imageUrl)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Merchant &&
//         other.uid == uid &&
//         other.fullName == fullName &&
//         other.shopName == shopName &&
//         other.email == email &&
//         other.password == password &&
//         other.imageUrl == imageUrl;
//   }

//   @override
//   int get hashCode {
//     return uid.hashCode ^
//         fullName.hashCode ^
//         shopName.hashCode ^
//         email.hashCode ^
//         password.hashCode ^
//         imageUrl.hashCode;
//   }
// }
