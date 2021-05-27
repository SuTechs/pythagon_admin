import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';

import '../constants.dart';
import '../data/utils/modal/collectionRef.dart';
import '../widgets/iconTextField.dart';
import '../widgets/showToast.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _pass = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkModePrimaryColor,
      body: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// email
                  IconTextField(
                    labelText: 'User',
                    icon: Icons.person,
                    controller: _email,
                    isRequired: true,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.username],
                  ),

                  /// pass
                  IconTextField(
                    labelText: 'Pass',
                    icon: Icons.lock,
                    controller: _pass,
                    obscureText: true,
                    isRequired: true,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: [AutofillHints.password],
                    onSubmit: () => login(context),
                  ),

                  SizedBox(height: 8),

                  if (_isLoading)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: LinearProgressIndicator(
                        color: Colors.green,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    if (_isLoading) return;

    if (_formKey.currentState == null || !_formKey.currentState!.validate())
      return;

    setState(() {
      _isLoading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _pass.text.trim());

      final u = credential.user;
      if (u != null) {
        _formKey.currentState!.save();

        /// use to create new admin
        // // if not verified
        // if (!u.emailVerified) {
        //   u.sendEmailVerification();
        //   await u.updateProfile(
        //       photoURL: kBlankProfilePicUrl, displayName: 'Pythagon');
        //
        //   await CollectionRef.admins.doc(u.email).set({
        //     'email': u.email,
        //     'id': u.uid,
        //     'name': 'Pythagon',
        //     'profilePic': kBlankProfilePicUrl,
        //   });
        // }

        CollectionRef.admins.doc(u.email).update({
          'lastLogin': Timestamp.now(),
        }).then((value) {
          print('Last login updated');
        });

        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (_) => AssignmentHome()),
        //     (route) => false);
        UserData().isLoggedIn = true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email')
        showToast('Invalid Username!');
      else if (e.code == 'user-not-found')
        showToast('Invalid Username!');
      else if (e.code == 'wrong-password')
        showToast('Invalid Password!');
      else
        showToast('${e.message}');

      setState(() {
        _isLoading = false;
      });
    }
  }
}
