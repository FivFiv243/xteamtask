import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rive/rive.dart';
import 'package:xteamtask/bloc/app_bloc/app_bloc.dart';
import 'package:xteamtask/fetures/rive_utils/rive_utils.dart';
import 'package:xteamtask/screens/weather_screen.dart';
import 'package:xteamtask/screens/map_screen.dart';
import 'package:xteamtask/screens/settings_screen.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _AppBloc.add(MapEvent());
  }

  @override
  Widget build(BuildContext context) {
    final QueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.all(2),
          child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 0.123, spreadRadius: 0.453, offset: Offset(3, 3)),
              ], color: Colors.white60, border: Border.all(color: const Color.fromARGB(96, 0, 0, 0))),
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
                        _AppBloc.add(WeatherEvent());
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

                      //Map Icon

                      Container(
                    width: 65,
                    height: 65,
                    child: GestureDetector(
                      onTap: () {
                        MapTrigger.fire();
                        _AppBloc.add(MapEvent());
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

                      //Settings Icon

                      Container(
                    width: 65,
                    height: 65,
                    child: GestureDetector(
                      onTap: () {
                        SettingsTrigger.fire();
                        _AppBloc.add(SettingsEvent());
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
              return MapScreen();
            }
            //There Map Screen end there

            //There Weather Screen down there
            if (state is WeatherState) {
              return WeatherScreen();
            }
            //There Weather Screen end there

            //There Settings Screen down there
            if (state is SettingsState) {
              return SettingsScreen();
            }
            //There Settings Screen end there

            //There else screen
            else {
              return SafeArea(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
