import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/fechamento_caixa_detalhes/bloc/fechamento_caixa_detalhes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:cocoverde/entities/fechamento_caixa_detalhes/fechamento_caixa_detalhes_model.dart';
import 'fechamento_caixa_detalhes_route.dart';
import 'package:time_machine/time_machine.dart';

class FechamentoCaixaDetalhesUpdateScreen extends StatelessWidget {
  FechamentoCaixaDetalhesUpdateScreen({Key? key}) : super(key: FechamentoCaixaDetalhesRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FechamentoCaixaDetalhesBloc, FechamentoCaixaDetalhesState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, FechamentoCaixaDetalhesRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<FechamentoCaixaDetalhesBloc, FechamentoCaixaDetalhesState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit FechamentoCaixaDetalhes':
'Create FechamentoCaixaDetalhes';
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
    return BlocBuilder<FechamentoCaixaDetalhesBloc, FechamentoCaixaDetalhesState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(FechamentoCaixaDetalhesState state, BuildContext context) {
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
    return BlocBuilder<FechamentoCaixaDetalhesBloc, FechamentoCaixaDetalhesState>(
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
            onPressed: state.isValid ? () => context.read<FechamentoCaixaDetalhesBloc>().add(FechamentoCaixaDetalhesFormSubmitted()) : null,
          );
        }
    );
  }
}
