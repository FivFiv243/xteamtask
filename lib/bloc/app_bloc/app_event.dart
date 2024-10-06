part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {}

class LogInEvent extends AppEvent {
  final email;
  final password;
  final cont;
  @override
  LogInEvent({required this.email, required this.password, required this.cont});
  List<Object?> get props => [email, password, cont];
}

class RegistrationEvent extends AppEvent {
  final email;
  final password;
  final cont;
  RegistrationEvent({required this.email, required this.password, required this.cont});
  @override
  List<Object?> get props => [email, password, cont];
}

class LogoutEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class MapEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class WeatherEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class SettingsEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}
