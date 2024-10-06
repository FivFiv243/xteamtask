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
        'name': _MailController[0] + _MailController[2] + _MailController[3] + _MailController[5] + _MailController[7],
        'avatareURI': 'https://i.ytimg.com/vi/o1WdXILi2K4/hqdefault.jpg',
        'interests': [],
        'chatedBefore': [],
        'group': false
      }, SetOptions(merge: true));
      await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('chats');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
