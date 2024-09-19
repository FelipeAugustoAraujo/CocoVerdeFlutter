import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/configuracao/bloc/configuracao_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:cocoverde/entities/configuracao/configuracao_model.dart';
import 'configuracao_route.dart';
import 'package:time_machine/time_machine.dart';

class ConfiguracaoUpdateScreen extends StatelessWidget {
  ConfiguracaoUpdateScreen({Key? key}) : super(key: ConfiguracaoRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConfiguracaoBloc, ConfiguracaoState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, ConfiguracaoRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<ConfiguracaoBloc, ConfiguracaoState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Configuracaos':
'Create Configuracaos';
                 return Text(title);
                }
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: <Widget>[settingsForm(context)]),
          ),
      ),
    );
  }

  Widget settingsForm(BuildContext context) {
    return Form(
      child: Wrap(runSpacing: 15, children: <Widget>[
        validationZone(),
        submit(context)
      ]),
    );
  }



  Widget validationZone() {
    return BlocBuilder<ConfiguracaoBloc, ConfiguracaoState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(ConfiguracaoState state, BuildContext context) {
    String notificationTranslated = '';
    Color? notificationColors;

    if (state.generalNotificationKey.toString().compareTo(HttpUtils.errorServerKey) == 0) {
      notificationTranslated ='Something wrong when calling the server, please try again';
      notificationColors = Theme.of(context).errorColor;
    } else if (state.generalNotificationKey.toString().compareTo(HttpUtils.badRequestServerKey) == 0) {
      notificationTranslated ='Something wrong happened with the received data';
      notificationColors = Theme.of(context).errorColor;
    }

    return Text(
      notificationTranslated,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
          color: notificationColors),
    );
  }

  submit(BuildContext context) {
    return BlocBuilder<ConfiguracaoBloc, ConfiguracaoState>(
        buildWhen: (previous, current) => previous.isValid != current.isValid,
        builder: (context, state) {
          String buttonLabel = state.editMode == true ?
'Edit':
'Create';
          return ElevatedButton(
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Visibility(
                    replacement: CircularProgressIndicator(value: null),
                    visible: !state.formStatus.isInProgress,
                    child: Text(buttonLabel),
                  ),
                )),
            onPressed: state.isValid ? () => context.read<ConfiguracaoBloc>().add(ConfiguracaoFormSubmitted()) : null,
          );
        }
    );
  }
}
