// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// // Project imports:
// import 'package:pay_qr/Screens/register_screen/retailer_sign_up.dart';
// import 'package:pay_qr/config/constants.dart';

// import 'package:pay_qr/services/database.dart';

// class AdminRetailer extends StatefulWidget {
//   const AdminRetailer({Key? key}) : super(key: key);

//   @override
//   _AdminRetailerState createState() => _AdminRetailerState();
// }

// class _AdminRetailerState extends State<AdminRetailer> {
//   late final Database _database = Database();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
     
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Get.to(() => const RetailerSignupPage());
//             },
//             icon: const Icon(
//               Icons.add,
//               color: Colors.white,
//             ),
//             iconSize: 25,
//           )
//         ],
//         title: const Text("Manage Retailer"),
//       ),
//       //firebase ki datatype
//       body: StreamBuilder<QuerySnapshot>(
//         stream:
//             FirebaseFirestore.instance.collection(kMerchantDb).snapshots(),
//         builder: (context, snapshot) {
//           return (snapshot.connectionState == ConnectionState.waiting)
//               ? const Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                   itemCount: snapshot.data?.docs.length,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot data = snapshot.data!.docs[index];
//                     return Card(
//                       clipBehavior: Clip.hardEdge,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20)),
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 5, vertical: 5),
//                       child: ListTile(
//                         // tileColor: kBtnColor,
//                         trailing: IconButton(
//                             onPressed: () async {
//                               _database.deleteFirebaseUser(data['email'],
//                                   data['password'], kMerchantDb, data.id);
//                             },
//                             icon: const Icon(Icons.delete_outline)),
//                         leading: const Icon(Icons.person),
//                         title: Text(data['fullName']),
//                         subtitle: Text(
//                           data['email'],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//         },
//       ),
//     );
//   }
// }
