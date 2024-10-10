import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/funcionario/bloc/funcionario_bloc.dart';
import 'package:Cocoverde/entities/funcionario/funcionario_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'funcionario_route.dart';


class FuncionarioViewScreen extends StatelessWidget {
  FuncionarioViewScreen({Key? key}) : super(key: FuncionarioRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Funcionarios View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<FuncionarioBloc, FuncionarioState>(
              buildWhen: (previous, current) => previous.loadedFuncionario != current.loadedFuncionario,
              builder: (context, state) {
                return Visibility(
                  visible: state.funcionarioStatusUI == FuncionarioStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    funcionarioCard(state.loadedFuncionario, context),

                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, FuncionarioRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget funcionarioCard(Funcionario funcionario, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + funcionario.id.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Nome : ' + funcionario.nome.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Data Nascimento : ' + funcionario.dataNascimento.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Identificador : ' + funcionario.identificador.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Telefone : ' + funcionario.telefone.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                // Instant
              Text('Data Cadastro : ' + (funcionario.dataCadastro != null ? DateFormat.yMMMMd('en').format(funcionario.dataCadastro!.toDateTimeLocal()) : ''), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Valor Base : ' + funcionario.valorBase.toString(), style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}
