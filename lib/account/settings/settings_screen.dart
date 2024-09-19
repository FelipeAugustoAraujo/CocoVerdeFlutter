import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/account/settings/bloc/settings_bloc.dart';
import 'package:Cocoverde/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';
import 'package:formz/formz.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';

import 'bloc/settings_models.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen() : super(key: CocoverdeKeys.settingsScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BlocBuilder<SettingsBloc, SettingsState>(
              buildWhen: (previous, current) => previous.firstName != current.firstName
                  || current.action == SettingsAction.reloadForLanguage,
              builder: (context, state) {
                return Text('Settings');
              })
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: <Widget>[settingsForm(context)]),
        ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer())
    );
  }

  Widget settingsForm(BuildContext context) {
          return Form(
            child: Wrap(runSpacing: 15, children: <Widget>[
              FirstNameField(),
              LastNameNameField(),
              emailField(),
              notificationZone(),
              submit(context)
            ]),
          );
  }

  Widget FirstNameField() {
    return BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) => previous.firstName != current.firstName
            || current.action == SettingsAction.reloadForLanguage,
        builder: (context, state) {
          return TextFormField(
              controller: context.read<SettingsBloc>().FirstNameController,
              onChanged: (value) { context.read<SettingsBloc>().add(FirstNameChanged(firstName: value)); },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText:'Firstname',
                  errorText: state.firstName.isNotValid ? FirstNameValidationError.invalid.invalidMessage : null));
        }
    );
  }

  Widget LastNameNameField() {
    return BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) => previous.lastName != current.lastName
            || current.action == SettingsAction.reloadForLanguage,
        builder: (context, state) {
          return TextFormField(
              controller: context.read<SettingsBloc>().LastNameController,
              onChanged: (value) { context.read<SettingsBloc>().add(LastNameChanged(lastName: value)); },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText:'Lastname',
                  errorText: state.lastName.isNotValid ? LastNameValidationError.invalid.invalidMessage : null));
        }
    );
  }

  Widget emailField() {
    return BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) => previous.email != current.email
            || current.action == SettingsAction.reloadForLanguage,
        builder: (context, state) {
          return TextFormField(
              controller: context.read<SettingsBloc>().emailController,
              onChanged: (value) { context.read<SettingsBloc>().add(EmailChanged(email: value)); },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText:'Email',
                  errorText: state.email.isNotValid ? EmailValidationError.invalid.invalidMessage : null));
        }
    );
  }

  submit(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
        return ElevatedButton(
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Visibility(
                  replacement: CircularProgressIndicator(value: null),
                  visible: !state.formStatus.isInProgress,
                  child: Text('SAVE'),
                ),
              )),
          onPressed: state.isValid ? () => context.read<SettingsBloc>().add(FormSubmitted()) : null,
        );
      }
    );
  }

  Widget notificationZone() {
    return BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(SettingsState state, BuildContext context) {
    String notificationTranslated = '';
    Color? notificationColors;
    if(state.generalNotificationKey.compareTo(SettingsBloc.successKey) == 0) {
      notificationTranslated ='Settings saved !';
      notificationColors = Theme.of(context).primaryColor;
    } else if(state.generalNotificationKey.compareTo(HttpUtils.errorServerKey) == 0) {
      notificationTranslated ='Something wrong happended with the data';
      notificationColors = Theme.of(context).errorColor;
    } else if (state.generalNotificationKey.compareTo(HttpUtils.errorServerKey) == 0) {
      notificationTranslated ='Something wrong when calling the server, please try again';
      notificationColors = Theme.of(context).errorColor;
    }

    return Text(
      notificationTranslated,
      style: TextStyle(color: notificationColors),
    );
  }
}
