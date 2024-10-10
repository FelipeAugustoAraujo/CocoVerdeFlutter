import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/frente/bloc/frente_bloc.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';
import 'frente_route.dart';
import 'package:time_machine/time_machine.dart';

class FrenteUpdateScreen extends StatelessWidget {
  FrenteUpdateScreen({Key? key}) : super(key: FrenteRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FrenteBloc, FrenteState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, FrenteRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<FrenteBloc, FrenteState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Frentes':
'Create Frentes';
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
          quantidadeField(),
          criadoEmField(),
          modificadoEmField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget quantidadeField() {
        return BlocBuilder<FrenteBloc, FrenteState>(
            buildWhen: (previous, current) => previous.quantidade != current.quantidade,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FrenteBloc>().quantidadeController,
                  onChanged: (value) { context.read<FrenteBloc>()
                    .add(QuantidadeChanged(quantidade:int.parse(value))); },
                  keyboardType:TextInputType.number,                  decoration: InputDecoration(
                      labelText:'quantidade'));
            }
        );
      }
      Widget criadoEmField() {
        return BlocBuilder<FrenteBloc, FrenteState>(
            buildWhen: (previous, current) => previous.criadoEm != current.criadoEm,
            builder: (context, state) {
              return DateTimeField(
                controller: context.read<FrenteBloc>().criadoEmController,
                onChanged: (value) { context.read<FrenteBloc>().add(CriadoEmChanged(criadoEm: Instant.dateTime(value!))); },
                format: DateFormat.yMMMMd('en'),
                keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText:'criadoEm',),
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
      Widget modificadoEmField() {
        return BlocBuilder<FrenteBloc, FrenteState>(
            buildWhen: (previous, current) => previous.modificadoEm != current.modificadoEm,
            builder: (context, state) {
              return DateTimeField(
                controller: context.read<FrenteBloc>().modificadoEmController,
                onChanged: (value) { context.read<FrenteBloc>().add(ModificadoEmChanged(modificadoEm: Instant.dateTime(value!))); },
                format: DateFormat.yMMMMd('en'),
                keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText:'modificadoEm',),
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
    return BlocBuilder<FrenteBloc, FrenteState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(FrenteState state, BuildContext context) {
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
    return BlocBuilder<FrenteBloc, FrenteState>(
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
            onPressed: state.isValid ? () => context.read<FrenteBloc>().add(FrenteFormSubmitted()) : null,
          );
        }
    );
  }
}
