import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:Cocoverde/account/settings/bloc/settings_models.dart';
import 'package:Cocoverde/shared/models/user.dart';
import 'package:Cocoverde/shared/repository/account_repository.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';

part 'settings_events.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AccountRepository _accountRepository;
  final emailController = TextEditingController();
  final FirstNameController = TextEditingController();
  final LastNameController = TextEditingController();

  SettingsBloc({required AccountRepository accountRepository}) :
        _accountRepository = accountRepository, super(const SettingsState());

  static final String loginExistKey = 'error.userexists';
  static final String emailExistKey = 'error.emailexists';
  static final String successKey = 'success.settings';

  @override
  void onTransition(Transition<SettingsEvent, SettingsState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is FirstNameChanged) {
     yield* onFirstNameChange(event);
    } else if (event is LastNameChanged) {
     yield* onLastNameChange(event);
    } else if (event is EmailChanged) {
      yield* onEmailChange(event);
    }    else if (event is FormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadCurrentUser) {
      yield* onLoadCurrentUser();
    }
  }

  Stream<SettingsState> onSubmit() async* {
    if (state.isValid) {
      yield state.copyWith(status: FormzSubmissionStatus.inProgress);
      SettingsAction action = SettingsAction.none;
      try {

        User newCurrentUser = User(state.currentUser.firstName, state.currentUser.lastName, state.email.value,
            state.currentUser.password,null, state.firstName.value, state.lastName.value);

        String? result = await _accountRepository.saveAccount(newCurrentUser);

        if (result?.compareTo(HttpUtils.successResult) != 0) {
          yield state.copyWith(status: FormzSubmissionStatus.failure,
              generalNotificationKey: result);
        } else {
          yield state.copyWith(currentUser: newCurrentUser,
              status: FormzSubmissionStatus.success, action: action
          , generalNotificationKey: successKey);
        }
      } catch (e) {
        yield state.copyWith(status: FormzSubmissionStatus.failure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }


  Stream<SettingsState> onEmailChange(EmailChanged event) async* {
    final email = EmailInput.dirty(event.email);
    yield state.copyWith(
      email: email,
      //status: Formz.validate([state.firstname, email, state.lastname]),
    );
  }

  Stream<SettingsState> onLastNameChange(LastNameChanged event) async* {
    final lastname = LastNameInput.dirty(event.lastName);
    yield state.copyWith(
      lastName: lastname,
      //status: Formz.validate([state.firstname, lastname, state.email]),
    );
  }

  Stream<SettingsState> onFirstNameChange(FirstNameChanged event) async* {
    final firstName = FirstNameInput.dirty(event.firstName);
    yield state.copyWith(
     firstName: firstName,
      //status: Formz.validate([firstname, state.lastname, state.email]),
   );
 }

  Stream<SettingsState> onLoadCurrentUser() async* {
    User? currentUser = await _accountRepository.getIdentity();
    String firstName = (currentUser?.firstName != null ? currentUser?.firstName: '')!;
    String lastName = (currentUser?.lastName != null ? currentUser?.lastName: '')!;
    String email = (currentUser?.email != null ? currentUser?.email: '')!;

    final firstNameInput = FirstNameInput.dirty(firstName);
    final lastNameInput = LastNameInput.dirty(lastName);
    final emailInput = EmailInput.dirty(email);

    yield state.copyWith(
      firstName: firstNameInput,
      lastName: lastNameInput,
        email: emailInput,
        currentUser: currentUser,
        //status: Formz.validate([firstNameInput, lastNameInput, emailInput])
    );

    emailController.text = email;
    LastNameController.text = firstName;
    FirstNameController.text = lastName;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    LastNameController.dispose();
    FirstNameController.dispose();
    return super.close();
  }
}
