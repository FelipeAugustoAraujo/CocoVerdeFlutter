import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/cidade/bloc/cidade_bloc.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';
import 'package:Cocoverde/entities/cidade/cidade_model.dart';
import 'package:formz/formz.dart';
import 'cidade_route.dart';

class CidadeUpdateScreen extends StatelessWidget {
  CidadeUpdateScreen({Key? key}) : super(key: CidadeRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CidadeBloc, CidadeState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, CidadeRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<CidadeBloc, CidadeState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Cidades':
'Create Cidades';
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
          estadoField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget nomeField() {
        return BlocBuilder<CidadeBloc, CidadeState>(
            buildWhen: (previous, current) => previous.nome != current.nome,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<CidadeBloc>().nomeController,
                  onChanged: (value) { context.read<CidadeBloc>()
                    .add(NomeChanged(nome:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'nome'));
            }
        );
      }
      Widget estadoField() {
        return BlocBuilder<CidadeBloc,CidadeState>(
            buildWhen: (previous, current) => previous.estado != current.estado,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('estado', style: Theme.of(context).textTheme.bodyLarge,),
                    DropdownButton<Estado>(
                        value: state.estado.value,
                        onChanged: (value) { context.read<CidadeBloc>().add(EstadoChanged(estado: value!)); },
                        items: createDropdownEstadoItems(Estado.values)),
                  ],
                ),
              );
            });
      }

      List<DropdownMenuItem<Estado>> createDropdownEstadoItems(List<Estado> estados) {
        List<DropdownMenuItem<Estado>> estadoDropDown = [];

        for (Estado estado in estados) {
          DropdownMenuItem<Estado> dropdown = DropdownMenuItem<Estado>(
              value: estado, child: Text(estado.toString()));
              estadoDropDown.add(dropdown);
        }

        return estadoDropDown;
      }

  Widget validationZone() {
    return BlocBuilder<CidadeBloc, CidadeState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(CidadeState state, BuildContext context) {
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
    return BlocBuilder<CidadeBloc, CidadeState>(
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
            onPressed: state.isValid ? () => context.read<CidadeBloc>().add(CidadeFormSubmitted()) : null,
          );
        }
    );
  }
}
