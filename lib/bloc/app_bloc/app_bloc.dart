import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xteamtask/firebase_things/firebase_auth.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
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
    on<MapEvent>((event, emit) {
      try {
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
  }
}
