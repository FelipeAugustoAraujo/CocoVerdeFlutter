import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/routes.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:flutter/material.dart';

import 'package:Cocoverde/entities/cidade/cidade_route.dart';
import 'package:Cocoverde/entities/cliente/cliente_route.dart';
import 'package:Cocoverde/entities/configuracao/configuracao_route.dart';
import 'package:Cocoverde/entities/detalhes_entrada_financeira/detalhes_entrada_financeira_route.dart';
import 'package:Cocoverde/entities/detalhes_saida_financeira/detalhes_saida_financeira_route.dart';
import 'package:Cocoverde/entities/dia_trabalho/dia_trabalho_route.dart';
import 'package:Cocoverde/entities/endereco/endereco_route.dart';
import 'package:Cocoverde/entities/entrada_financeira/entrada_financeira_route.dart';
import 'package:Cocoverde/entities/estoque/estoque_route.dart';
import 'package:Cocoverde/entities/fechamento_caixa/fechamento_caixa_route.dart';
import 'package:Cocoverde/entities/fechamento_caixa_detalhes/fechamento_caixa_detalhes_route.dart';
import 'package:Cocoverde/entities/fornecedor/fornecedor_route.dart';
import 'package:Cocoverde/entities/frente/frente_route.dart';
import 'package:Cocoverde/entities/funcionario/funcionario_route.dart';
import 'package:Cocoverde/entities/imagem/imagem_route.dart';
import 'package:Cocoverde/entities/produto/produto_route.dart';
import 'package:Cocoverde/entities/saida_financeira/saida_financeira_route.dart';
// jhipster-fredy-needle-menu-import-entry-add

class CocoverdeDrawer extends StatelessWidget {
   CocoverdeDrawer({Key? key}) : super(key: key);

   static final double iconSize = 30;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DrawerBloc, DrawerState>(
      listener: (context, state) {
        if(state.isLogout) {
          Navigator.popUntil(context, ModalRoute.withName(CocoverdeRoutes.login));
          Navigator.pushNamed(context, CocoverdeRoutes.login);
        }
      },
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            header(context),
            ListTile(
              leading: Icon(Icons.home, size: iconSize,),
              title: Text('Home'),
              onTap: () => Navigator.pushNamed(context, CocoverdeRoutes.main),
            ),
            ListTile(
              leading: Icon(Icons.settings, size: iconSize,),
              title: Text('Settings'),
              onTap: () => Navigator.pushNamed(context, CocoverdeRoutes.settings),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, size: iconSize,),
          title: Text('Sign out'),
              onTap: () => context.read<DrawerBloc>().add(Logout())
            ),
            Divider(thickness: 2),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('Cidades'),
                onTap: () => Navigator.pushNamed(context, CidadeRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('Clientes'),
                onTap: () => Navigator.pushNamed(context, ClienteRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('Configuracaos'),
                onTap: () => Navigator.pushNamed(context, ConfiguracaoRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('DetalhesEntradaFinanceiras'),
                onTap: () => Navigator.pushNamed(context, DetalhesEntradaFinanceiraRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('DetalhesSaidaFinanceiras'),
                onTap: () => Navigator.pushNamed(context, DetalhesSaidaFinanceiraRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('DiaTrabalhos'),
                onTap: () => Navigator.pushNamed(context, DiaTrabalhoRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('Enderecos'),
                onTap: () => Navigator.pushNamed(context, EnderecoRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('EntradaFinanceiras'),
                onTap: () => Navigator.pushNamed(context, EntradaFinanceiraRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('Estoques'),
                onTap: () => Navigator.pushNamed(context, EstoqueRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('FechamentoCaixas'),
                onTap: () => Navigator.pushNamed(context, FechamentoCaixaRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('FechamentoCaixaDetalhes'),
                onTap: () => Navigator.pushNamed(context, FechamentoCaixaDetalhesRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('Fornecedors'),
                onTap: () => Navigator.pushNamed(context, FornecedorRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('Frentes'),
                onTap: () => Navigator.pushNamed(context, FrenteRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('Funcionarios'),
                onTap: () => Navigator.pushNamed(context, FuncionarioRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('Imagems'),
                onTap: () => Navigator.pushNamed(context, ImagemRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('Produtos'),
                onTap: () => Navigator.pushNamed(context, ProdutoRoutes.list),
            ),
            ListTile(
                leading: Icon(Icons.label, size: iconSize,),
                title: Text('SaidaFinanceiras'),
                onTap: () => Navigator.pushNamed(context, SaidaFinanceiraRoutes.list),
            ),
            // jhipster-fredy-needle-menu-entry-add
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Text('Menu',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
