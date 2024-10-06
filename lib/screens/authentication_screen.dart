import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:xteamtask/bloc/app_bloc/app_bloc.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

//cotrollers
final _MailController = TextEditingController();
final _PasswordController = TextEditingController();
final _PasswordConfirmingController = TextEditingController();

//bloc
final _AppBloc = AppBloc();
bool ConfirmPasswordBolean = false;

class _AuthScreenState extends State<AuthScreen> {
  //initState
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final QueryWidth = MediaQuery.of(context).size.width;
    final QueryHight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: BlocBuilder<AppBloc, AppState>(
            bloc: _AppBloc,
            builder: (context, state) {
              return SafeArea(
                  child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          Container(
                            width: QueryWidth / 1.3,
                            child: TextField(
                              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Your password',
                                labelStyle: TextStyle(color: Colors.black87),
                                border: UnderlineInputBorder(),
                                disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid)),
                              ),
                              controller: _PasswordController,
                              maxLength: 64,
                              onChanged: (value) => _PasswordController.text,
                            ),
                          ),

                          //Animated Text Field

                          TweenAnimationBuilder(
                            tween: Tween(
                              begin: ConfirmPasswordBolean ? QueryWidth / 4 : QueryWidth + 1,
                              end: ConfirmPasswordBolean ? QueryWidth + 1 : QueryWidth / 4,
                            ),
                            duration: Duration(milliseconds: 500),
                            builder: (BuildContext contextW, double value1, _) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(value1 / 2, 0, value1 / 2, 0),
                                width: QueryWidth / 1.3,
                                child: TextField(
                                  style: TextStyle(color: Colors.black87),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm your password',
                                    labelStyle: TextStyle(color: Colors.black87),
                                    border: UnderlineInputBorder(),
                                  ),
                                  enabled: ConfirmPasswordBolean == false,
                                  controller: _PasswordConfirmingController,
                                  maxLength: 64,
                                  onChanged: (value) => _PasswordConfirmingController.text,
                                ),
                              );
                            },
                          ),
                          PrettyWaveButton(
                            child: const Text(
                              'Start',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (ConfirmPasswordBolean == false) {
                                if (_PasswordConfirmingController.text.trim() == _PasswordController.text.trim()) {
                                  _AppBloc.add(RegistrationEvent(email: _MailController.text, password: _PasswordController.text, cont: context));
                                } else {
                                  //add show dialog
                                  debugPrint("throw Error");
                                }
                              } else {
                                _AppBloc.add(LogInEvent(email: _MailController.text, password: _PasswordController.text, cont: context));
                              }
                            },
                          ),
                          PrettySlideUpButton(
                              firstChild: Text(
                                "log in to an existing one",
                                style: TextStyle(color: Colors.white),
                              ),
                              secondChild: Text(
                                "register an account",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  ConfirmPasswordBolean = !ConfirmPasswordBolean;
                                });
                              })
                        ],
                      )));
            }));
  }
}
