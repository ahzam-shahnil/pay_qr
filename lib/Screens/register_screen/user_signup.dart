// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:ndialog/ndialog.dart';

// Project imports:
import 'package:pay_qr/Components/rounded_input_field.dart';
import 'package:pay_qr/Components/rounded_password_field.dart';
import 'package:pay_qr/config/constants.dart';

class UserSignupPage extends StatefulWidget {
  static String id = 'signup_page';

  const UserSignupPage({Key? key}) : super(key: key);

  @override
  _UserSignupPageState createState() => _UserSignupPageState();
}

class _UserSignupPageState extends State<UserSignupPage> {
  Logger log = Logger();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp(BuildContext context) async {
    var fullName = _nameController.text.trim();
    var email = _emailController.text.trim();
    var password = _passwordController.text.trim();

    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      // show error toast

      Fluttertoast.showToast(
          msg: 'Please fill all fields', backgroundColor: kBtnColor);
      return;
    }

    if (password.length < 6) {
      // show error toast
      Fluttertoast.showToast(
          msg: 'Weak Password, at least 6 characters are required');

      return;
    }

    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Signing Up'),
      message: const Text('Please wait'),
      dismissable: false,
      blur: 2,
    );

    progressDialog.show();

    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      log.i('before database');

      if (userCredential.user != null) {
        final FirebaseFirestore _firestore = FirebaseFirestore.instance;
        final CollectionReference _mainCollection;

        //* Checking User to store Data
        if (selected == 0) {
          _mainCollection = _firestore.collection(kMerchantDb);
        } else {
          _mainCollection = _firestore.collection(kUserDb);
        }

        log.i('after database');

        String uid = userCredential.user!.uid;

        DocumentReference documentReferencer = _mainCollection.doc(uid);

        Map<String, dynamic> data = <String, dynamic>{
          'fullName': fullName,
          'email': email,
          'password': password,
          'uid': uid,
        };

        await documentReferencer
            .set(data)
            .whenComplete(() => log.i("Item item added to the database"))
            .catchError((e) => log.e(e));

        log.i('after database were');
        progressDialog.dismiss();
        Fluttertoast.showToast(msg: 'Success');
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(msg: 'Failed');
      }

      progressDialog.dismiss();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Email is already in Use');
      } else if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Password is weak');
      }
    } catch (e) {
      progressDialog.dismiss();
      log.i('catch sign up : $e');
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  int selected = 2;

  Widget radioButton(String text, int value) {
    return Material(
      color: (selected == value)
          ? const Color(0xFFFE725D)
          : const Color(0xFF30475E),
      borderRadius: BorderRadius.circular(25),
      elevation: 5,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            selected = value;
          });
        },
        minWidth: 30,
        height: 15,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        elevation: 2.0,
        shadowColor: kActiveBtnColor,
        // automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 80.0,
            ),
            RoundedInputField(
              hintText: 'Enter your name',
              icon: Icons.person,
              textController: _nameController,
              textInputType: TextInputType.name,
            ),
            const SizedBox(
              height: 30.0,
            ),
            RoundedInputField(
              hintText: 'Enter your email',
              icon: Icons.email,
              textController: _emailController,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 30.0,
            ),
            RoundedPasswordField(
              textController: _passwordController,
            ),
            const SizedBox(
              height: 70.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 15),
                radioButton('Customer', 2),
              ],
            ),
            const SizedBox(
              height: 70.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: OutlinedButton(
                onPressed: () {
                  _signUp(context);
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  elevation: 5.0,
                  side: const BorderSide(
                    color: kActiveBtnColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
