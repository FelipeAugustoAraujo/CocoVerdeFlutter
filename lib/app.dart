import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/bloc/login_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/account/register/bloc/register_bloc.dart';
import 'package:Cocoverde/account/settings/settings_screen.dart';
import 'package:Cocoverde/main/bloc/main_bloc.dart';
import 'package:Cocoverde/routes.dart';
import 'package:Cocoverde/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/repository/account_repository.dart';
import 'package:Cocoverde/themes.dart';
import 'account/settings/bloc/settings_bloc.dart';

import 'account/login/login_screen.dart';
import 'account/register/register_screen.dart';


import 'entities/cidade/cidade_route.dart';
import 'entities/cliente/cliente_route.dart';
import 'entities/configuracao/configuracao_route.dart';
import 'entities/detalhes_entrada_financeira/detalhes_entrada_financeira_route.dart';
import 'entities/detalhes_saida_financeira/detalhes_saida_financeira_route.dart';
import 'entities/dia_trabalho/dia_trabalho_route.dart';
import 'entities/endereco/endereco_route.dart';
import 'entities/entrada_financeira/entrada_financeira_route.dart';
import 'entities/estoque/estoque_route.dart';
import 'entities/fechamento_caixa/fechamento_caixa_route.dart';
import 'entities/fechamento_caixa_detalhes/fechamento_caixa_detalhes_route.dart';
import 'entities/fornecedor/fornecedor_route.dart';
import 'entities/frente/frente_route.dart';
import 'entities/funcionario/funcionario_route.dart';
import 'entities/imagem/imagem_route.dart';
import 'entities/produto/produto_route.dart';
import 'entities/saida_financeira/saida_financeira_route.dart';
// jhipster-fredy-needle-import-add - JHipster will add new imports here

class CocoverdeApp extends StatelessWidget {
  const CocoverdeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cocoverde app',
      theme: Themes.jhLight,
      routes: {
        CocoverdeRoutes.login: (context) {
          return BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(loginRepository: LoginRepository()),
            child: LoginScreen());
        },
        CocoverdeRoutes.register: (context) {
          return BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(accountRepository: AccountRepository()),
            child: RegisterScreen());
        },
        CocoverdeRoutes.main: (context) {
          return BlocProvider<MainBloc>(
            create: (context) => MainBloc(accountRepository: AccountRepository())
              ..add(Init()),
            child: MainScreen());
        },
      CocoverdeRoutes.settings: (context) {
        return BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(accountRepository: AccountRepository())
            ..add(LoadCurrentUser()),
          child: SettingsScreen());
        },
        ...CidadeRoutes.map,
        ...ClienteRoutes.map,
        ...ConfiguracaoRoutes.map,
        ...DetalhesEntradaFinanceiraRoutes.map,
        ...DetalhesSaidaFinanceiraRoutes.map,
        ...DiaTrabalhoRoutes.map,
        ...EnderecoRoutes.map,
        ...EntradaFinanceiraRoutes.map,
        ...EstoqueRoutes.map,
        ...FechamentoCaixaRoutes.map,
        ...FechamentoCaixaDetalhesRoutes.map,
        ...FornecedorRoutes.map,
        ...FrenteRoutes.map,
        ...FuncionarioRoutes.map,
        ...ImagemRoutes.map,
        ...ProdutoRoutes.map,
        ...SaidaFinanceiraRoutes.map,
        // jhipster-fredy-needle-route-add - JHipster will add new routes here
      },
    );
  }
}
