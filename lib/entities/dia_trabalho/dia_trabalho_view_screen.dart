import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/dia_trabalho/bloc/dia_trabalho_bloc.dart';
import 'package:Cocoverde/entities/dia_trabalho/dia_trabalho_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'dia_trabalho_route.dart';

class DiaTrabalhoViewScreen extends StatelessWidget {
  DiaTrabalhoViewScreen({Key? key}) : super(key: DiaTrabalhoRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('DiaTrabalhos View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<DiaTrabalhoBloc, DiaTrabalhoState>(
              buildWhen: (previous, current) => previous.loadedDiaTrabalho != current.loadedDiaTrabalho,
              builder: (context, state) {
                return Visibility(
                  visible: state.diaTrabalhoStatusUI == DiaTrabalhoStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    diaTrabalhoCard(state.loadedDiaTrabalho, context),
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, DiaTrabalhoRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget diaTrabalhoCard(DiaTrabalho diaTrabalho, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + diaTrabalho.id.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                // Instant
              Text('Data : ' + (diaTrabalho.data != null ? DateFormat.yMMMMd('en').format(diaTrabalho.data!.toDateTimeLocal()) : ''), style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}
