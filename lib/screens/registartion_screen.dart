import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

final _MailController = TextEditingController();
final _PasswordController = TextEditingController();
final _PasswordConfirmingController = TextEditingController();

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final QueryWidth = MediaQuery.of(context).size.width;
    final QueryHight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, QueryHight / 15, 0, 0),
          ),
          Lottie.asset("lib/assets/lottie_animations/LottieAnimationMap.json", height: QueryWidth / 2.25, width: QueryWidth / 2.25),
          Padding(
            padding: EdgeInsets.fromLTRB(0, QueryHight / 15, 0, 0),
          ),
          Container(
            width: QueryWidth / 1.3,
            child: TextField(
              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
              decoration: InputDecoration(
                labelText: 'Your mail',
                labelStyle: TextStyle(color: Colors.black87),
                border: UnderlineInputBorder(),
                disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid)),
              ),
              controller: _MailController,
              maxLength: 254,
              onChanged: (value) => _MailController.text,
            ),
          ),
        ],
      ))),
    );
  }
}
