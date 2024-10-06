import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStorages {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future userReggister(String _MailController) async {
    try {
      await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'mail': _MailController,
        'MapDots': [],
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
