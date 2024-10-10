import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/produto/bloc/produto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';
import 'produto_route.dart';

class ProdutoUpdateScreen extends StatelessWidget {
  ProdutoUpdateScreen({Key? key}) : super(key: ProdutoRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProdutoBloc, ProdutoState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, ProdutoRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<ProdutoBloc, ProdutoState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Produtos':
'Create Produtos';
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
          descricaoField(),
          valorBaseField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget nomeField() {
        return BlocBuilder<ProdutoBloc, ProdutoState>(
            buildWhen: (previous, current) => previous.nome != current.nome,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProdutoBloc>().nomeController,
                  onChanged: (value) { context.read<ProdutoBloc>()
                    .add(NomeChanged(nome:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'nome'));
            }
        );
      }
      Widget descricaoField() {
        return BlocBuilder<ProdutoBloc, ProdutoState>(
            buildWhen: (previous, current) => previous.descricao != current.descricao,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProdutoBloc>().descricaoController,
                  onChanged: (value) { context.read<ProdutoBloc>()
                    .add(DescricaoChanged(descricao:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'descricao'));
            }
        );
      }
      Widget valorBaseField() {
        return BlocBuilder<ProdutoBloc, ProdutoState>(
            buildWhen: (previous, current) => previous.valorBase != current.valorBase,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ProdutoBloc>().valorBaseController,
                  onChanged: (value) { context.read<ProdutoBloc>()
                    .add(ValorBaseChanged(valorBase:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valorBase'));
            }
        );
      }


  Widget validationZone() {
    return BlocBuilder<ProdutoBloc, ProdutoState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(ProdutoState state, BuildContext context) {
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
    return BlocBuilder<ProdutoBloc, ProdutoState>(
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
            onPressed: state.isValid ? () => context.read<ProdutoBloc>().add(ProdutoFormSubmitted()) : null,
          );
        }
    );
  }
}
