import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/dia_trabalho/bloc/dia_trabalho_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:cocoverde/entities/dia_trabalho/dia_trabalho_model.dart';
import 'dia_trabalho_route.dart';
import 'package:time_machine/time_machine.dart';

class DiaTrabalhoUpdateScreen extends StatelessWidget {
  DiaTrabalhoUpdateScreen({Key? key}) : super(key: DiaTrabalhoRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiaTrabalhoBloc, DiaTrabalhoState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, DiaTrabalhoRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<DiaTrabalhoBloc, DiaTrabalhoState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit DiaTrabalhos':
'Create DiaTrabalhos';
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
          dataField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget dataField() {
        return BlocBuilder<DiaTrabalhoBloc, DiaTrabalhoState>(
            buildWhen: (previous, current) => previous.data != current.data,
            builder: (context, state) {
              return DateTimeField(
                controller: context.read<DiaTrabalhoBloc>().dataController,
                onChanged: (value) { context.read<DiaTrabalhoBloc>().add(DataChanged(data: Instant.dateTime(value!))); },
                format: DateFormat.yMMMMd('en'),
                keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText:'data',),
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
    return BlocBuilder<DiaTrabalhoBloc, DiaTrabalhoState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(DiaTrabalhoState state, BuildContext context) {
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
    return BlocBuilder<DiaTrabalhoBloc, DiaTrabalhoState>(
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
            onPressed: state.isValid ? () => context.read<DiaTrabalhoBloc>().add(DiaTrabalhoFormSubmitted()) : null,
          );
        }
    );
  }
}
