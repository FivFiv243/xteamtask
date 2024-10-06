import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xteamtask/firebase_things/firebase_storages.dart';

class FirebaseAuthFeatures {
  final _fireauth = FirebaseAuth.instance;
//Registration function
  Future RegisterWithEmailAndPassword(String _email, String _password, BuildContext cont) async {
    try {
      await _fireauth.createUserWithEmailAndPassword(email: _email, password: _password);
      await FireStorages().userReggister(_email);
      return showDialog(
          context: cont,
          builder: (cont) => AlertDialog(
                backgroundColor: Colors.green,
                title: Text("Check your email"),
                content: Text("We sent to you an message with confirming link."),
              ));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          {
            return showDialog(
                context: cont,
                builder: (cont) => AlertDialog(
                      backgroundColor: Colors.red,
                      title: Text("It's done"),
                      content: Text("Accaunt with your email addres already exist. You can use Forget password field."),
                    ));
          }
        case "invalid-email":
          {
            return showDialog(
                context: cont,
                builder: (cont) => AlertDialog(
                      backgroundColor: Colors.red,
                      title: Text("Your email is invalid!"),
                      content: Text("Please check email field!"),
                    ));
          }
        case "too-many-requests":
          {
            return showDialog(
                context: cont,
                builder: (cont) => AlertDialog(
                      backgroundColor: Colors.red,
                      title: Text("Too many request!"),
                      content: Text("Please take a breake and comeback later"),
                    ));
          }
        case "network-request-failed":
          {
            return showDialog(
                context: cont,
                builder: (cont) => AlertDialog(
                      backgroundColor: Colors.red,
                      title: Text("Request failed!"),
                      content: Text("Please check your internet conection!"),
                    ));
          }
        default:
          {
            return showDialog(
                context: cont,
                builder: (cont) => AlertDialog(
                      backgroundColor: Colors.red,
                      title: Text("Something gone wrong"),
                      content: Text("We dont know what happend, take a break and try again later"),
                    ));
          }
      }
    } catch (e) {}
  }

//signing out function
  Future SignOutAcc() async {
    try {
      _fireauth.signOut();
    } catch (e) {
      debugPrint('signing out func gone wrong');
    }
  }

//Login function
  Future LogInWithEmailANdPassword(String _email, String _password, BuildContext cont) async {
    try {
      await _fireauth.currentUser?.reload();
      await _fireauth.signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          {
            return showDialog(
                context: cont,
                builder: (cont) => AlertDialog(
                      backgroundColor: Colors.red,
                      title: Text("Ooops"),
                      content: Text("We have no user with your email"),
                    ));
          }
        case "wrong-password":
          {
            return showDialog(
                context: cont,
                builder: (cont) => AlertDialog(
                      backgroundColor: Colors.red,
                      title: Text("Wrong password"),
                      content: Text("It's not a password for this email"),
                    ));
          }
        case "user-disabled":
          {
            return showDialog(
                context: cont,
                builder: (cont) => AlertDialog(
                      backgroundColor: Colors.red,
                      title: Text("You are banned"),
                      content: Text("Your accaunt is disabled"),
                    ));
          }
        case "user-not-found":
          {
            return showDialog(
                context: cont,
                builder: (cont) => AlertDialog(
                      backgroundColor: Colors.red,
                      title: Text("Got banned"),
                      content: Text("Your accaunt is disabled"),
                    ));
          }
        case "too-many-requests":
          {
            return showDialog(
                context: cont,
                builder: (cont) => AlertDialog(
                      backgroundColor: Colors.red,
                      title: Text("Too many request!"),
                      content: Text("Please take a breake and comeback later"),
                    ));
          }
        case "network-request-failed":
          {
            return showDialog(
                context: cont,
                builder: (cont) => AlertDialog(
                      backgroundColor: Colors.red,
                      title: Text("Request failed!"),
                      content: Text("Please check your internet conection!"),
                    ));
          }
        default:
          {
            return showDialog(
                context: cont,
                builder: (cont) => AlertDialog(
                      backgroundColor: Colors.red,
                      title: Text("Something gone wrong"),
                      content: Text("We dont know what happend, take a break and try again later"),
                    ));
          }
      }
    } catch (e) {}
  }
}
