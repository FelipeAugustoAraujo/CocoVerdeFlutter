part of 'register_bloc.dart';

class RegisterState extends Equatable with FormzMixin {
  final NameInput name;
  final FirstNameInput firstName;
  final LastNameInput lastName;
  final EmailInput email;
  final PasswordInput password;
  final ConfirmPasswordInput confirmPassword;
  final TermsAndConditionsInput termsAndConditions;
  final FormzSubmissionStatus status;
  final String generalErrorKey;

  const RegisterState({
    this.name = const NameInput.pure(),
    this.firstName = const FirstNameInput.pure(),
    this.lastName = const LastNameInput.pure(),
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
    this.termsAndConditions = const TermsAndConditionsInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.generalErrorKey = HttpUtils.generalNoErrorKey
  });

  RegisterState copyWith({
    NameInput? name,
    FirstNameInput? firstName,
    LastNameInput? lastName,
    EmailInput? email,
    PasswordInput? password,
    ConfirmPasswordInput? confirmPassword,
    TermsAndConditionsInput? termsAndConditions,
    FormzSubmissionStatus? status,
    String? generalErrorKey
  }) {
    return RegisterState(
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      status: status ?? this.status,
      generalErrorKey: generalErrorKey ?? this.generalErrorKey,
    );
  }

  @override
  List<Object> get props => [name, firstName, lastName, email, password, confirmPassword, termsAndConditions, status, generalErrorKey];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [name,firstName,lastName,email,password,confirmPassword,termsAndConditions];
}
