
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';

import 'bloc/imagem_bloc.dart';
import 'imagem_list_screen.dart';
import 'imagem_repository.dart';
import 'imagem_update_screen.dart';
import 'imagem_view_screen.dart';

class ImagemRoutes {
  static final list = '/entities/imagem-list';
  static final create = '/entities/imagem-create';
  static final edit = '/entities/imagem-edit';
  static final view = '/entities/imagem-view';

  static const listScreenKey = Key('__imagemListScreen__');
  static const createScreenKey = Key('__imagemCreateScreen__');
  static const editScreenKey = Key('__imagemEditScreen__');
  static const viewScreenKey = Key('__imagemViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<ImagemBloc>(
          create: (context) => ImagemBloc(imagemRepository: ImagemRepository())
            ..add(InitImagemList()),
          child: ImagemListScreen());
    },
    create: (context) {
      return BlocProvider<ImagemBloc>(
          create: (context) => ImagemBloc(imagemRepository: ImagemRepository()),
          child: ImagemUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ImagemBloc>(
          create: (context) => ImagemBloc(imagemRepository: ImagemRepository())
            ..add(LoadImagemByIdForEdit(id: arguments.id)),
          child: ImagemUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ImagemBloc>(
          create: (context) => ImagemBloc(imagemRepository: ImagemRepository())
            ..add(LoadImagemByIdForView(id: arguments.id)),
          child: ImagemViewScreen());
    },
  };
}
