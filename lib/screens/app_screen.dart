import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';
import 'package:rive/rive.dart';
import 'package:xteamtask/bloc/app_bloc/app_bloc.dart';
import 'package:xteamtask/fetures/rive_utils/rive_utils.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

final _AppBloc = AppBloc();

late SMITrigger WeatherTrigger;
late SMITrigger MapTrigger;
late SMITrigger SettingsTrigger;

class _AppScreenState extends State<AppScreen> {
  @override
  Widget build(BuildContext context) {
    final QueryWidth = MediaQuery.of(context).size.width;
    final QueryHight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.all(8),
          child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 0.123, spreadRadius: 0.453, offset: Offset(3, 3)),
              ], color: Colors.white60, border: Border.all(color: const Color.fromARGB(96, 0, 0, 0)), borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
              height: 65,
              child: Row(children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(QueryWidth / 150, 0, 0, 0),
                  child:

                      //Weather Icon

                      Container(
                    width: 65,
                    height: 65,
                    child: GestureDetector(
                      onTap: () {
                        WeatherTrigger.fire();
                      },
                      child: RiveAnimation.asset(
                        "lib/assets/rive_animation_presset/x_team_task_animationpresset.riv",
                        artboard: "WeatherBoard",
                        onInit: (artboard) {
                          StateMachineController controller = RiveUtils.GetRiveController(artboard, StateMachineName: "State Machine 1");
                          WeatherTrigger = controller.findSMI("Trigger 1");
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(QueryWidth / 5, 0, 0, 0),
                  child:

                      //Weather Icon

                      Container(
                    width: 65,
                    height: 65,
                    child: GestureDetector(
                      onTap: () {
                        MapTrigger.fire();
                      },
                      child: RiveAnimation.asset(
                        "lib/assets/rive_animation_presset/x_team_task_animationpresset.riv",
                        artboard: "MapBoard",
                        onInit: (artboard) {
                          StateMachineController controller = RiveUtils.GetRiveController(artboard, StateMachineName: "State Machine 1");
                          MapTrigger = controller.findSMI("Trigger 1");
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(QueryWidth / 5, 0, 0, 0),
                  child:

                      //Weather Icon

                      Container(
                    width: 65,
                    height: 65,
                    child: GestureDetector(
                      onTap: () {
                        SettingsTrigger.fire();
                      },
                      child: RiveAnimation.asset(
                        "lib/assets/rive_animation_presset/x_team_task_animationpresset.riv",
                        artboard: "SettingsBoard",
                        onInit: (artboard) {
                          StateMachineController controller = RiveUtils.GetRiveController(artboard, StateMachineName: "State Machine 1");
                          SettingsTrigger = controller.findSMI("Trigger 1");
                        },
                      ),
                    ),
                  ),
                ),
              ]))),
      body: BlocBuilder<AppBloc, AppState>(
          bloc: _AppBloc,
          builder: (context, state) {
            //There Map Screen Down there
            if (state is MapState) {
              return SafeArea(
                child: Text("MapHere"),
              );
            }
            //There Map Screen end there

            //There Weather Screen down there
            if (state is WeatherState) {
              return SafeArea(child: Text("WeatherHere"));
            }
            //There Weather Screen end there

            //There Settings Screen down there
            if (state is SettingsState) {
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
            //There Settings Screen end there

            //There else screen
            else {
              return SafeArea(
                  child: OutlinedButton(
                      onPressed: () {
                        _AppBloc.add(MapEvent());
                      },
                      child: Text("Retry")));
            }
          }),
    );
  }
}
