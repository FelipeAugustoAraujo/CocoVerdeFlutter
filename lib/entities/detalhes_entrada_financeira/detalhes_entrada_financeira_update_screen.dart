import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/detalhes_entrada_financeira/bloc/detalhes_entrada_financeira_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:cocoverde/entities/detalhes_entrada_financeira/detalhes_entrada_financeira_model.dart';
import 'detalhes_entrada_financeira_route.dart';
import 'package:time_machine/time_machine.dart';

class DetalhesEntradaFinanceiraUpdateScreen extends StatelessWidget {
  DetalhesEntradaFinanceiraUpdateScreen({Key? key}) : super(key: DetalhesEntradaFinanceiraRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetalhesEntradaFinanceiraBloc, DetalhesEntradaFinanceiraState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, DetalhesEntradaFinanceiraRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<DetalhesEntradaFinanceiraBloc, DetalhesEntradaFinanceiraState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit DetalhesEntradaFinanceiras':
'Create DetalhesEntradaFinanceiras';
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
          quantidadeItemField(),
          valorField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget quantidadeItemField() {
        return BlocBuilder<DetalhesEntradaFinanceiraBloc, DetalhesEntradaFinanceiraState>(
            buildWhen: (previous, current) => previous.quantidadeItem != current.quantidadeItem,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DetalhesEntradaFinanceiraBloc>().quantidadeItemController,
                  onChanged: (value) { context.read<DetalhesEntradaFinanceiraBloc>()
                    .add(QuantidadeItemChanged(quantidadeItem:int.parse(value))); },
                  keyboardType:TextInputType.number,                  decoration: InputDecoration(
                      labelText:'quantidadeItem'));
            }
        );
      }
      Widget valorField() {
        return BlocBuilder<DetalhesEntradaFinanceiraBloc, DetalhesEntradaFinanceiraState>(
            buildWhen: (previous, current) => previous.valor != current.valor,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<DetalhesEntradaFinanceiraBloc>().valorController,
                  onChanged: (value) { context.read<DetalhesEntradaFinanceiraBloc>()
                    .add(ValorChanged(valor:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valor'));
            }
        );
      }


  Widget validationZone() {
    return BlocBuilder<DetalhesEntradaFinanceiraBloc, DetalhesEntradaFinanceiraState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(DetalhesEntradaFinanceiraState state, BuildContext context) {
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
    return BlocBuilder<DetalhesEntradaFinanceiraBloc, DetalhesEntradaFinanceiraState>(
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
            onPressed: state.isValid ? () => context.read<DetalhesEntradaFinanceiraBloc>().add(DetalhesEntradaFinanceiraFormSubmitted()) : null,
          );
        }
    );
  }
}
