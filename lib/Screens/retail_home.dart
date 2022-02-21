// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pay_qr/Screens/user_product_add.dart';
// import 'package:pay_qr/config/constants.dart';
// import 'package:pay_qr/services/database.dart';

// class RetailHome extends StatefulWidget {
//   const RetailHome({Key? key}) : super(key: key);

//   @override
//   _RetailHomeState createState() => _RetailHomeState();
// }

// class _RetailHomeState extends State<RetailHome> {
//   late final Database _database = Database();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kScaffoldBgColor,
//         shadowColor: kBtnColor,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Get.to(() => const ProductCreate());
//             },
//             icon: const Icon(
//               Icons.add,
//               color: Colors.white,
//             ),
//             iconSize: 25,
//           )
//         ],
//         title: const Text("Manage Products"),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection(kProductDb).snapshots(),
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
//                       child:

//                           //
//                           ListTile(
//                         tileColor: kBtnColor,
//                         isThreeLine: true,
//                         trailing: IconButton(
//                             onPressed: () async {
//                               _database.deleteItem(
//                                   docId: data.id, collectionName: kProductDb);
//                             },
//                             icon: const Icon(Icons.delete_outline)),
//                         leading: const Icon(Icons.person),
//                         title: Text(data['title']),
//                         subtitle: Text(
//                           "Discount = " +
//                               data['discount'] +
//                               "\n Rs. Price: " +
//                               data['price'],
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
