import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/endereco/bloc/endereco_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:cocoverde/entities/endereco/endereco_model.dart';
import 'endereco_route.dart';
import 'package:time_machine/time_machine.dart';

class EnderecoUpdateScreen extends StatelessWidget {
  EnderecoUpdateScreen({Key? key}) : super(key: EnderecoRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EnderecoBloc, EnderecoState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, EnderecoRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<EnderecoBloc, EnderecoState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Enderecos':
'Create Enderecos';
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
          cepField(),
          logradouroField(),
          numeroField(),
          complementoField(),
          bairroField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget cepField() {
        return BlocBuilder<EnderecoBloc, EnderecoState>(
            buildWhen: (previous, current) => previous.cep != current.cep,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<EnderecoBloc>().cepController,
                  onChanged: (value) { context.read<EnderecoBloc>()
                    .add(CepChanged(cep:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'cep'));
            }
        );
      }
      Widget logradouroField() {
        return BlocBuilder<EnderecoBloc, EnderecoState>(
            buildWhen: (previous, current) => previous.logradouro != current.logradouro,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<EnderecoBloc>().logradouroController,
                  onChanged: (value) { context.read<EnderecoBloc>()
                    .add(LogradouroChanged(logradouro:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'logradouro'));
            }
        );
      }
      Widget numeroField() {
        return BlocBuilder<EnderecoBloc, EnderecoState>(
            buildWhen: (previous, current) => previous.numero != current.numero,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<EnderecoBloc>().numeroController,
                  onChanged: (value) { context.read<EnderecoBloc>()
                    .add(NumeroChanged(numero:int.parse(value))); },
                  keyboardType:TextInputType.number,                  decoration: InputDecoration(
                      labelText:'numero'));
            }
        );
      }
      Widget complementoField() {
        return BlocBuilder<EnderecoBloc, EnderecoState>(
            buildWhen: (previous, current) => previous.complemento != current.complemento,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<EnderecoBloc>().complementoController,
                  onChanged: (value) { context.read<EnderecoBloc>()
                    .add(ComplementoChanged(complemento:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'complemento'));
            }
        );
      }
      Widget bairroField() {
        return BlocBuilder<EnderecoBloc, EnderecoState>(
            buildWhen: (previous, current) => previous.bairro != current.bairro,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<EnderecoBloc>().bairroController,
                  onChanged: (value) { context.read<EnderecoBloc>()
                    .add(BairroChanged(bairro:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'bairro'));
            }
        );
      }


  Widget validationZone() {
    return BlocBuilder<EnderecoBloc, EnderecoState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(EnderecoState state, BuildContext context) {
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
    return BlocBuilder<EnderecoBloc, EnderecoState>(
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
            onPressed: state.isValid ? () => context.read<EnderecoBloc>().add(EnderecoFormSubmitted()) : null,
          );
        }
    );
  }
}
