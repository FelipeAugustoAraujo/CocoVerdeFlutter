import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/cliente/bloc/cliente_bloc.dart';
import 'package:cocoverde/entities/cliente/cliente_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'cliente_route.dart';


class ClienteViewScreen extends StatelessWidget {
  ClienteViewScreen({Key? key}) : super(key: ClienteRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Clientes View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ClienteBloc, ClienteState>(
              buildWhen: (previous, current) => previous.loadedCliente != current.loadedCliente,
              builder: (context, state) {
                return Visibility(
                  visible: state.clienteStatusUI == ClienteStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    clienteCard(state.loadedCliente, context),

                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ClienteRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget clienteCard(Cliente cliente, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + cliente.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Nome : ' + cliente.nome.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Data Nascimento : ' + cliente.dataNascimento.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Identificador : ' + cliente.identificador.toString(), style: Theme.of(context).textTheme.bodyText1,),
                // Instant
              Text('Data Cadastro : ' + (cliente.dataCadastro != null ? DateFormat.yMMMMd('en').format(cliente.dataCadastro!.toDateTimeLocal()) : ''), style: Theme.of(context).textTheme.bodyText1,),
                Text('Telefone : ' + cliente.telefone.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
