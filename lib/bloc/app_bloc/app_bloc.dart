import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xteamtask/fetures/map_logic/marker_class.dart';
import 'package:xteamtask/firebase_things/firebase_auth.dart';
import 'package:xteamtask/firebase_things/firebase_storages.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    //auth events

    on<AppEvent>((event, emit) {
      try {} catch (e) {}
    });
    on<LogInEvent>((event, emit) {
      try {
        FirebaseAuthFeatures().LogInWithEmailANdPassword(event.email, event.password, event.cont);
        emit(LoginState());
      } catch (e) {}
    });
    on<RegistrationEvent>((event, emit) {
      try {
        FirebaseAuthFeatures().RegisterWithEmailAndPassword(event.email, event.password, event.cont);
        emit(RegistrationState());
      } catch (e) {}
    });
    on<LogoutEvent>((event, emit) {
      FirebaseAuthFeatures().SignOutAcc();
      emit(RegistrationState());
    });

    //app events

    on<MapEvent>((event, emit) {
      try {
        FireStorages().getPoints();
        emit(MapState());
      } catch (e) {}
    });
    on<WeatherEvent>((event, emit) {
      try {
        emit(WeatherState());
      } catch (e) {}
    });
    on<SettingsEvent>((event, emit) {
      try {
        emit(SettingsState());
      } catch (e) {}
    });
    on<AddNewPointEvent>((event, emit) {
      FireStorages().PushPoint(event.NewMapMarker).whenComplete(() {
        emit(MapState());
      });
    });
  }
}
