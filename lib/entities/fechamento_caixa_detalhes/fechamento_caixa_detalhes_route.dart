
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';

import 'bloc/fechamento_caixa_detalhes_bloc.dart';
import 'fechamento_caixa_detalhes_list_screen.dart';
import 'fechamento_caixa_detalhes_repository.dart';
import 'fechamento_caixa_detalhes_update_screen.dart';
import 'fechamento_caixa_detalhes_view_screen.dart';

class FechamentoCaixaDetalhesRoutes {
  static final list = '/entities/fechamentoCaixaDetalhes-list';
  static final create = '/entities/fechamentoCaixaDetalhes-create';
  static final edit = '/entities/fechamentoCaixaDetalhes-edit';
  static final view = '/entities/fechamentoCaixaDetalhes-view';

  static const listScreenKey = Key('__fechamentoCaixaDetalhesListScreen__');
  static const createScreenKey = Key('__fechamentoCaixaDetalhesCreateScreen__');
  static const editScreenKey = Key('__fechamentoCaixaDetalhesEditScreen__');
  static const viewScreenKey = Key('__fechamentoCaixaDetalhesViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<FechamentoCaixaDetalhesBloc>(
          create: (context) => FechamentoCaixaDetalhesBloc(fechamentoCaixaDetalhesRepository: FechamentoCaixaDetalhesRepository())
            ..add(InitFechamentoCaixaDetalhesList()),
          child: FechamentoCaixaDetalhesListScreen());
    },
    create: (context) {
      return BlocProvider<FechamentoCaixaDetalhesBloc>(
          create: (context) => FechamentoCaixaDetalhesBloc(fechamentoCaixaDetalhesRepository: FechamentoCaixaDetalhesRepository()),
          child: FechamentoCaixaDetalhesUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<FechamentoCaixaDetalhesBloc>(
          create: (context) => FechamentoCaixaDetalhesBloc(fechamentoCaixaDetalhesRepository: FechamentoCaixaDetalhesRepository())
            ..add(LoadFechamentoCaixaDetalhesByIdForEdit(id: arguments.id)),
          child: FechamentoCaixaDetalhesUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<FechamentoCaixaDetalhesBloc>(
          create: (context) => FechamentoCaixaDetalhesBloc(fechamentoCaixaDetalhesRepository: FechamentoCaixaDetalhesRepository())
            ..add(LoadFechamentoCaixaDetalhesByIdForView(id: arguments.id)),
          child: FechamentoCaixaDetalhesViewScreen());
    },
  };
}
