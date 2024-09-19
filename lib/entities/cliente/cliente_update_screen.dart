import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/cliente/bloc/cliente_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:cocoverde/entities/cliente/cliente_model.dart';
import 'cliente_route.dart';
import 'package:time_machine/time_machine.dart';

class ClienteUpdateScreen extends StatelessWidget {
  ClienteUpdateScreen({Key? key}) : super(key: ClienteRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClienteBloc, ClienteState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, ClienteRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<ClienteBloc, ClienteState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Clientes':
'Create Clientes';
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
          dataCadastroField(),
          telefoneField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget nomeField() {
        return BlocBuilder<ClienteBloc, ClienteState>(
            buildWhen: (previous, current) => previous.nome != current.nome,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ClienteBloc>().nomeController,
                  onChanged: (value) { context.read<ClienteBloc>()
                    .add(NomeChanged(nome:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'nome'));
            }
        );
      }
      Widget dataNascimentoField() {
        return BlocBuilder<ClienteBloc, ClienteState>(
            buildWhen: (previous, current) => previous.dataNascimento != current.dataNascimento,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ClienteBloc>().dataNascimentoController,
                  onChanged: (value) { context.read<ClienteBloc>()
                    .add(DataNascimentoChanged(dataNascimento:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'dataNascimento'));
            }
        );
      }
      Widget identificadorField() {
        return BlocBuilder<ClienteBloc, ClienteState>(
            buildWhen: (previous, current) => previous.identificador != current.identificador,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ClienteBloc>().identificadorController,
                  onChanged: (value) { context.read<ClienteBloc>()
                    .add(IdentificadorChanged(identificador:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'identificador'));
            }
        );
      }
      Widget dataCadastroField() {
        return BlocBuilder<ClienteBloc, ClienteState>(
            buildWhen: (previous, current) => previous.dataCadastro != current.dataCadastro,
            builder: (context, state) {
              return DateTimeField(
                controller: context.read<ClienteBloc>().dataCadastroController,
                onChanged: (value) { context.read<ClienteBloc>().add(DataCadastroChanged(dataCadastro: Instant.dateTime(value!))); },
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
      Widget telefoneField() {
        return BlocBuilder<ClienteBloc, ClienteState>(
            buildWhen: (previous, current) => previous.telefone != current.telefone,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ClienteBloc>().telefoneController,
                  onChanged: (value) { context.read<ClienteBloc>()
                    .add(TelefoneChanged(telefone:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'telefone'));
            }
        );
      }


  Widget validationZone() {
    return BlocBuilder<ClienteBloc, ClienteState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(ClienteState state, BuildContext context) {
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
    return BlocBuilder<ClienteBloc, ClienteState>(
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
            onPressed: state.isValid ? () => context.read<ClienteBloc>().add(ClienteFormSubmitted()) : null,
          );
        }
    );
  }
}
