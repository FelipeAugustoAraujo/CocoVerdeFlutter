import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/fornecedor/bloc/fornecedor_bloc.dart';
import 'package:Cocoverde/entities/fornecedor/fornecedor_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'fornecedor_route.dart';



import 'package:Cocoverde/entities/entrada_financeira/entrada_financeira_repository.dart';
import 'package:Cocoverde/entities/entrada_financeira/entrada_financeira_list_screen.dart';
import 'package:Cocoverde/entities/entrada_financeira/bloc/entrada_financeira_bloc.dart';

class FornecedorViewScreen extends StatelessWidget {
  FornecedorViewScreen({Key? key}) : super(key: FornecedorRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Fornecedors View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<FornecedorBloc, FornecedorState>(
              buildWhen: (previous, current) => previous.loadedFornecedor != current.loadedFornecedor,
              builder: (context, state) {
                return Visibility(
                  visible: state.fornecedorStatusUI == FornecedorStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    fornecedorCard(state.loadedFornecedor, context),



                        BlocProvider<EntradaFinanceiraBloc>(
                          create: (context) => EntradaFinanceiraBloc(entradaFinanceiraRepository: EntradaFinanceiraRepository())
                            ..add(InitEntradaFinanceiraListByFornecedor (fornecedorId: state.loadedFornecedor.id!)),
                          child: EntradaFinanceiraListScreen(scaffoldMode: false,)),
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, FornecedorRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget fornecedorCard(Fornecedor fornecedor, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + fornecedor.id.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Nome : ' + fornecedor.nome.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Identificador : ' + fornecedor.identificador.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Telefone : ' + fornecedor.telefone.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                // Instant
              Text('Data Cadastro : ' + (fornecedor.dataCadastro != null ? DateFormat.yMMMMd('en').format(fornecedor.dataCadastro!.toDateTimeLocal()) : ''), style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}
