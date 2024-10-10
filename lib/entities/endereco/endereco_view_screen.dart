import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/endereco/bloc/endereco_bloc.dart';
import 'package:Cocoverde/entities/endereco/endereco_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'endereco_route.dart';





class EnderecoViewScreen extends StatelessWidget {
  EnderecoViewScreen({Key? key}) : super(key: EnderecoRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Enderecos View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<EnderecoBloc, EnderecoState>(
              buildWhen: (previous, current) => previous.loadedEndereco != current.loadedEndereco,
              builder: (context, state) {
                return Visibility(
                  visible: state.enderecoStatusUI == EnderecoStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    enderecoCard(state.loadedEndereco, context),




                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, EnderecoRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget enderecoCard(Endereco endereco, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + endereco.id.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Cep : ' + endereco.cep.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Logradouro : ' + endereco.logradouro.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Numero : ' + endereco.numero.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Complemento : ' + endereco.complemento.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Bairro : ' + endereco.bairro.toString(), style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}
