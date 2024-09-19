part of 'settings_bloc.dart';

enum SettingsAction {none, reloadForLanguage}

class SettingsState extends Equatable with FormzMixin {
  final FirstNameInput firstName;
  final LastNameInput lastName;
  final EmailInput email;
  final FormzSubmissionStatus formStatus;
  final SettingsAction action;
  final String generalNotificationKey;
  final User currentUser;

  const SettingsState({
    this.firstName = const FirstNameInput.pure(),
    this.lastName = const LastNameInput.pure(),
    this.email = const EmailInput.pure(),
    this.action = SettingsAction.none,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = HttpUtils.generalNoErrorKey,
    this.currentUser = const User('', '', '', '', '', '','')
  });

  SettingsState copyWith({
    FirstNameInput? firstName,
    LastNameInput? lastName,
    EmailInput? email,
    FormzSubmissionStatus? status,
    String? generalNotificationKey,
    SettingsAction? action,
    User? currentUser
  }) {
    return SettingsState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      formStatus: status ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      action: action ?? this.action,
      currentUser: currentUser ?? this.currentUser
    );
  }

  @override
  List<Object> get props => [firstName, lastName, email,formStatus, generalNotificationKey];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [firstName, lastName, email];
}
