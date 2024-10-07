import 'package:flutter/material.dart';
import 'package:pretty_animated_buttons/widgets/pretty_slide_underline_button.dart';
import 'package:xteamtask/bloc/app_bloc/app_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

final _AppBloc = AppBloc();

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final QueryHight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Center(
      child: Column(children: [
        Padding(padding: EdgeInsets.fromLTRB(0, QueryHight / 3.5, 0, 0)),
        PrettySlideUnderlineButton(
            label: "Exit",
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 500)).whenComplete(() {
                _AppBloc.add(LogoutEvent());
              });
            })
      ]),
    ));
  }
}
