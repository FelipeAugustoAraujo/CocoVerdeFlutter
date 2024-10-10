import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/imagem/bloc/imagem_bloc.dart';
import 'package:Cocoverde/entities/imagem/imagem_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'imagem_route.dart';



class ImagemViewScreen extends StatelessWidget {
  ImagemViewScreen({Key? key}) : super(key: ImagemRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Imagems View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ImagemBloc, ImagemState>(
              buildWhen: (previous, current) => previous.loadedImagem != current.loadedImagem,
              builder: (context, state) {
                return Visibility(
                  visible: state.imagemStatusUI == ImagemStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    imagemCard(state.loadedImagem, context),


                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ImagemRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget imagemCard(Imagem imagem, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + imagem.id.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Name : ' + imagem.name.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Content Type : ' + imagem.contentType.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Description : ' + imagem.description.toString(), style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}
