import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../data/utils/modal/collectionRef.dart';
import '../widgets/iconTextField.dart';
import '../widgets/showToast.dart';

class AdminLogin extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkModePrimaryColor,
      body: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            key: _formKey,
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
                ),

                /// pass
                IconTextField(
                  labelText: 'Pass',
                  icon: Icons.lock,
                  controller: _pass,
                  obscureText: true,
                  isRequired: true,
                  textInputAction: TextInputAction.done,
                  onSubmit: () => login(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate())
      return;

    _formKey.currentState!.save();

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _pass.text.trim());

      final u = credential.user;
      if (u != null) {
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
        });
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
    }
  }
}
