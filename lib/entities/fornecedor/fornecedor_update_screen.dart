import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/fornecedor/bloc/fornecedor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';
import 'fornecedor_route.dart';
import 'package:time_machine/time_machine.dart';

class FornecedorUpdateScreen extends StatelessWidget {
  FornecedorUpdateScreen({Key? key}) : super(key: FornecedorRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FornecedorBloc, FornecedorState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, FornecedorRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<FornecedorBloc, FornecedorState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Fornecedors':
'Create Fornecedors';
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
          identificadorField(),
          telefoneField(),
          dataCadastroField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget nomeField() {
        return BlocBuilder<FornecedorBloc, FornecedorState>(
            buildWhen: (previous, current) => previous.nome != current.nome,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FornecedorBloc>().nomeController,
                  onChanged: (value) { context.read<FornecedorBloc>()
                    .add(NomeChanged(nome:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'nome'));
            }
        );
      }
      Widget identificadorField() {
        return BlocBuilder<FornecedorBloc, FornecedorState>(
            buildWhen: (previous, current) => previous.identificador != current.identificador,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FornecedorBloc>().identificadorController,
                  onChanged: (value) { context.read<FornecedorBloc>()
                    .add(IdentificadorChanged(identificador:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'identificador'));
            }
        );
      }
      Widget telefoneField() {
        return BlocBuilder<FornecedorBloc, FornecedorState>(
            buildWhen: (previous, current) => previous.telefone != current.telefone,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FornecedorBloc>().telefoneController,
                  onChanged: (value) { context.read<FornecedorBloc>()
                    .add(TelefoneChanged(telefone:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'telefone'));
            }
        );
      }
      Widget dataCadastroField() {
        return BlocBuilder<FornecedorBloc, FornecedorState>(
            buildWhen: (previous, current) => previous.dataCadastro != current.dataCadastro,
            builder: (context, state) {
              return DateTimeField(
                controller: context.read<FornecedorBloc>().dataCadastroController,
                onChanged: (value) { context.read<FornecedorBloc>().add(DataCadastroChanged(dataCadastro: Instant.dateTime(value!))); },
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


  Widget validationZone() {
    return BlocBuilder<FornecedorBloc, FornecedorState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(FornecedorState state, BuildContext context) {
    String notificationTranslated = '';
    Color? notificationColors;

    if (state.generalNotificationKey.toString().compareTo(HttpUtils.errorServerKey) == 0) {
      notificationTranslated ='Something wrong when calling the server, please try again';
      notificationColors = Theme.of(context).colorScheme.error;
    } else if (state.generalNotificationKey.toString().compareTo(HttpUtils.badRequestServerKey) == 0) {
      notificationTranslated ='Something wrong happened with the received data';
      notificationColors = Theme.of(context).colorScheme.error;
    }

    return Text(
      notificationTranslated,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
          color: notificationColors),
    );
  }

  submit(BuildContext context) {
    return BlocBuilder<FornecedorBloc, FornecedorState>(
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
            onPressed: state.isValid ? () => context.read<FornecedorBloc>().add(FornecedorFormSubmitted()) : null,
          );
        }
    );
  }
}
