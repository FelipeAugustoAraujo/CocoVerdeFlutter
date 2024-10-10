
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';

import 'bloc/configuracao_bloc.dart';
import 'configuracao_list_screen.dart';
import 'configuracao_repository.dart';
import 'configuracao_update_screen.dart';
import 'configuracao_view_screen.dart';

class ConfiguracaoRoutes {
  static final list = '/entities/configuracao-list';
  static final create = '/entities/configuracao-create';
  static final edit = '/entities/configuracao-edit';
  static final view = '/entities/configuracao-view';

  static const listScreenKey = Key('__configuracaoListScreen__');
  static const createScreenKey = Key('__configuracaoCreateScreen__');
  static const editScreenKey = Key('__configuracaoEditScreen__');
  static const viewScreenKey = Key('__configuracaoViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<ConfiguracaoBloc>(
          create: (context) => ConfiguracaoBloc(configuracaoRepository: ConfiguracaoRepository())
            ..add(InitConfiguracaoList()),
          child: ConfiguracaoListScreen());
    },
    create: (context) {
      return BlocProvider<ConfiguracaoBloc>(
          create: (context) => ConfiguracaoBloc(configuracaoRepository: ConfiguracaoRepository()),
          child: ConfiguracaoUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ConfiguracaoBloc>(
          create: (context) => ConfiguracaoBloc(configuracaoRepository: ConfiguracaoRepository())
            ..add(LoadConfiguracaoByIdForEdit(id: arguments.id)),
          child: ConfiguracaoUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ConfiguracaoBloc>(
          create: (context) => ConfiguracaoBloc(configuracaoRepository: ConfiguracaoRepository())
            ..add(LoadConfiguracaoByIdForView(id: arguments.id)),
          child: ConfiguracaoViewScreen());
    },
  };
}
