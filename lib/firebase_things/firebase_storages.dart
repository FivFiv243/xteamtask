import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xteamtask/fetures/map_logic/marker_class.dart';

class FireStorages {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future userReggister(String _MailController) async {
    try {
      await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'mail': _MailController,
      }, SetOptions(merge: true));
      await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("MapDote").doc();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future PushPoint(MarkerMapClass markerMap) async {
    try {
      await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("MapDots").add({
        'name': markerMap.name,
        'description': markerMap.description,
        'lat': markerMap.Lat,
        'lng': markerMap.Lng,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Stream<QuerySnapshot>> getPoints() async {
    try {
      return await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("MapDots").snapshots();
    } catch (e) {
      debugPrint(e.toString());
      return Stream.empty();
    }
  }
}
