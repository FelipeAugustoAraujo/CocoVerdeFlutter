part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class LoadCurrentUser extends SettingsEvent {}

class FirstNameChanged extends SettingsEvent {
  final String firstName;

  const FirstNameChanged({required this.firstName});

  @override
  List<Object> get props => [firstName];
}

class LastNameChanged extends SettingsEvent {
  final String lastName;

  const LastNameChanged({required this.lastName});

  @override
  List<Object> get props => [lastName];
}

class EmailChanged extends SettingsEvent {
  final String email;

  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}


class FormSubmitted extends SettingsEvent {}
