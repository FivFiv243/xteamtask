import 'package:rive/rive.dart';

class RiveUtils {
  static StateMachineController GetRiveController(Artboard artboard, {StateMachineName = "State Machine 1"}) {
    StateMachineController? controller = StateMachineController.fromArtboard(artboard, StateMachineName);
    artboard.addController(controller!);
    return controller;
  }
}
