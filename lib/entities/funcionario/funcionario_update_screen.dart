import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/funcionario/bloc/funcionario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:cocoverde/entities/funcionario/funcionario_model.dart';
import 'funcionario_route.dart';
import 'package:time_machine/time_machine.dart';

class FuncionarioUpdateScreen extends StatelessWidget {
  FuncionarioUpdateScreen({Key? key}) : super(key: FuncionarioRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FuncionarioBloc, FuncionarioState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, FuncionarioRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<FuncionarioBloc, FuncionarioState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Funcionarios':
'Create Funcionarios';
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
          nomeField(),
          dataNascimentoField(),
          identificadorField(),
          telefoneField(),
          dataCadastroField(),
          valorBaseField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget nomeField() {
        return BlocBuilder<FuncionarioBloc, FuncionarioState>(
            buildWhen: (previous, current) => previous.nome != current.nome,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FuncionarioBloc>().nomeController,
                  onChanged: (value) { context.read<FuncionarioBloc>()
                    .add(NomeChanged(nome:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'nome'));
            }
        );
      }
      Widget dataNascimentoField() {
        return BlocBuilder<FuncionarioBloc, FuncionarioState>(
            buildWhen: (previous, current) => previous.dataNascimento != current.dataNascimento,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FuncionarioBloc>().dataNascimentoController,
                  onChanged: (value) { context.read<FuncionarioBloc>()
                    .add(DataNascimentoChanged(dataNascimento:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'dataNascimento'));
            }
        );
      }
      Widget identificadorField() {
        return BlocBuilder<FuncionarioBloc, FuncionarioState>(
            buildWhen: (previous, current) => previous.identificador != current.identificador,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FuncionarioBloc>().identificadorController,
                  onChanged: (value) { context.read<FuncionarioBloc>()
                    .add(IdentificadorChanged(identificador:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'identificador'));
            }
        );
      }
      Widget telefoneField() {
        return BlocBuilder<FuncionarioBloc, FuncionarioState>(
            buildWhen: (previous, current) => previous.telefone != current.telefone,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FuncionarioBloc>().telefoneController,
                  onChanged: (value) { context.read<FuncionarioBloc>()
                    .add(TelefoneChanged(telefone:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'telefone'));
            }
        );
      }
      Widget dataCadastroField() {
        return BlocBuilder<FuncionarioBloc, FuncionarioState>(
            buildWhen: (previous, current) => previous.dataCadastro != current.dataCadastro,
            builder: (context, state) {
              return DateTimeField(
                controller: context.read<FuncionarioBloc>().dataCadastroController,
                onChanged: (value) { context.read<FuncionarioBloc>().add(DataCadastroChanged(dataCadastro: Instant.dateTime(value!))); },
                format: DateFormat.yMMMMd('en'),
                keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText:'dataCadastro',),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      locale: Locale('en'),
                      context: context,
                      firstDate: DateTime(1950),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2050));
                },
              );
            }
        );
      }
      Widget valorBaseField() {
        return BlocBuilder<FuncionarioBloc, FuncionarioState>(
            buildWhen: (previous, current) => previous.valorBase != current.valorBase,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FuncionarioBloc>().valorBaseController,
                  onChanged: (value) { context.read<FuncionarioBloc>()
                    .add(ValorBaseChanged(valorBase:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valorBase'));
            }
        );
      }


  Widget validationZone() {
    return BlocBuilder<FuncionarioBloc, FuncionarioState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(FuncionarioState state, BuildContext context) {
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
    return BlocBuilder<FuncionarioBloc, FuncionarioState>(
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
            onPressed: state.isValid ? () => context.read<FuncionarioBloc>().add(FuncionarioFormSubmitted()) : null,
          );
        }
    );
  }
}
