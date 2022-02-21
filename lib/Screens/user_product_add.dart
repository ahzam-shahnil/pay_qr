// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:logger/logger.dart';
// import 'package:ndialog/ndialog.dart';

// // Project imports:
// import 'package:pay_qr/Components/rounded_input_field.dart';
// import 'package:pay_qr/config/constants.dart';


// class ProductCreate extends StatefulWidget {
//   const ProductCreate({Key? key}) : super(key: key);

//   @override
//   _ProductCreateState createState() => _ProductCreateState();
// }

// class _ProductCreateState extends State<ProductCreate> {
//   Logger log = Logger();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _discountController = TextEditingController();

//   Future<void> _saveData(BuildContext context) async {
//     var title = _nameController.text.trim();
//     var price = _priceController.text.trim();
//     var description = _descriptionController.text.trim();
//     var discount = _discountController.text.trim();

//     if (title.isEmpty ||
//         description.isEmpty ||
//         price.isEmpty ||
//         discount.isEmpty ||
//         price.isEmpty) {
//       // show error toast

//       Fluttertoast.showToast(
//           msg: 'Please fill all fields', backgroundColor: kBtnColor);
//       return;
//     }

//     ProgressDialog progressDialog = ProgressDialog(
//       context,
//       title: const Text('Addding Product'),
//       message: const Text('Please wait'),
//       dismissable: false,
//       blur: 2,
//     );

//     progressDialog.show();

//     try {
//       log.i('before database');

//       if (FirebaseAuth.instance.currentUser != null) {
//         final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//         final CollectionReference _mainCollection =
//             _firestore.collection(kProductDb);

//         // log.i('after database');

//         String uid = FirebaseAuth.instance.currentUser!.uid;

//         DocumentReference documentReferencer = _mainCollection.doc(uid);

//         Map<String, dynamic> data = <String, dynamic>{
//           'title': title,
//           'description': description,
//           'price': price,
//           'discount': discount,
//         };

//         await documentReferencer
//             .set(data)
//             .whenComplete(() => log.i("Item item added to the database"))
//             .catchError((e) => log.e(e));

//         log.i('after database were');
//         progressDialog.dismiss();
//         Fluttertoast.showToast(msg: 'Success');
//         Navigator.of(context).pop();
//       } else {
//         Fluttertoast.showToast(msg: 'Failed');
//       }

//       progressDialog.dismiss();
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         Fluttertoast.showToast(msg: 'Email is already in Use');
//       } else if (e.code == 'weak-password') {
//         Fluttertoast.showToast(msg: 'Password is weak');
//       }
//     } catch (e) {
//       progressDialog.dismiss();
//       log.i('catch sign up : $e');
//       Fluttertoast.showToast(msg: 'Something went wrong');
//     }
//   }

//   int selected = 1;

//   Widget radioButton(String text, int value) {
//     return Material(
//       color: (selected == value)
//           ? const Color(0xFFFE725D)
//           : const Color(0xFF30475E),
//       borderRadius: BorderRadius.circular(25),
//       elevation: 5,
//       child: MaterialButton(
//         onPressed: () {
//           setState(() {
//             selected = value;
//           });
//         },
//         minWidth: 30,
//         height: 15,
//         child: Text(
//           text,
//           style: const TextStyle(
//               fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
    
//       appBar: AppBar(
       
//         title: const Text('Add Product'),
//         centerTitle: true,
//         elevation: 2.0,
//         shadowColor: kActiveBtnColor,
//         // automaticallyImplyLeading: false,
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: ListView(
//           padding: const EdgeInsets.all(20.0),
//           physics: const AlwaysScrollableScrollPhysics(),
//           shrinkWrap: true,
//           children: [
//             const SizedBox(
//               height: 80.0,
//             ),
//             RoundedInputField(
//               hintText: 'Enter product name',
//               icon: Icons.person,
//               textController: _nameController,
//               textInputType: TextInputType.name,
//             ),
//             const SizedBox(
//               height: 30.0,
//             ),
//             RoundedInputField(
//               hintText: 'Enter Price',
//               icon: Icons.email,
//               textController: _priceController,
//               textInputType: TextInputType.number,
//             ),
//             RoundedInputField(
//               hintText: 'Enter description',
//               icon: Icons.email,
//               textController: _descriptionController,
//               textInputType: TextInputType.text,
//             ),
//             RoundedInputField(
//               hintText: 'Enter discount',
//               icon: Icons.email,
//               textController: _discountController,
//               textInputType: TextInputType.number,
//             ),
//             const SizedBox(
//               height: 70.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // radioButton('Admin', 0),
//                 const SizedBox(width: 15),
//                 radioButton('Retailer', 1),
//                 const SizedBox(width: 15),
//                 // radioButton('Customer', 2),
//               ],
//             ),
//             const SizedBox(
//               height: 70.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 70),
//               child: OutlinedButton(
//                 onPressed: () {
//                   _saveData(context);
//                 },
//                 child: const Text(
//                   'Save Data',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w900,
//                       fontSize: 18,
//                       color: Colors.white),
//                 ),
//                 style: OutlinedButton.styleFrom(
//                   elevation: 5.0,
//                   side: const BorderSide(
//                     color: kActiveBtnColor,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
