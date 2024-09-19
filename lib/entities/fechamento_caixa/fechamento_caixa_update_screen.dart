import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/fechamento_caixa/bloc/fechamento_caixa_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:cocoverde/entities/fechamento_caixa/fechamento_caixa_model.dart';
import 'fechamento_caixa_route.dart';
import 'package:time_machine/time_machine.dart';

class FechamentoCaixaUpdateScreen extends StatelessWidget {
  FechamentoCaixaUpdateScreen({Key? key}) : super(key: FechamentoCaixaRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FechamentoCaixaBloc, FechamentoCaixaState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, FechamentoCaixaRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit FechamentoCaixas':
'Create FechamentoCaixas';
                 return Text(title);
                }
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: <Widget>[settingsForm(context)]),
          ),
      ),
    );
  }

  Widget settingsForm(BuildContext context) {
    return Form(
      child: Wrap(runSpacing: 15, children: <Widget>[
          dataInicialField(),
          dataFinalField(),
          quantidadeCocosPerdidosField(),
          quantidadeCocosVendidosField(),
          quantidadeCocoSobrouField(),
          divididoPorField(),
          valorTotalCocoField(),
          valorTotalCocoPerdidoField(),
          valorPorPessoaField(),
          valorDespesasField(),
          valorDinheiroField(),
          valorCartaoField(),
          valorTotalField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget dataInicialField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.dataInicial != current.dataInicial,
            builder: (context, state) {
              return DateTimeField(
                controller: context.read<FechamentoCaixaBloc>().dataInicialController,
                onChanged: (value) { context.read<FechamentoCaixaBloc>().add(DataInicialChanged(dataInicial: Instant.dateTime(value!))); },
                format: DateFormat.yMMMMd('en'),
                keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText:'dataInicial',),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      locale: Locale('en'),
                      context: context,
                      firstDate: DateTime(1950),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2050));
                },
              );
            }
        );
      }
      Widget dataFinalField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.dataFinal != current.dataFinal,
            builder: (context, state) {
              return DateTimeField(
                controller: context.read<FechamentoCaixaBloc>().dataFinalController,
                onChanged: (value) { context.read<FechamentoCaixaBloc>().add(DataFinalChanged(dataFinal: Instant.dateTime(value!))); },
                format: DateFormat.yMMMMd('en'),
                keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText:'dataFinal',),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      locale: Locale('en'),
                      context: context,
                      firstDate: DateTime(1950),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2050));
                },
              );
            }
        );
      }
      Widget quantidadeCocosPerdidosField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.quantidadeCocosPerdidos != current.quantidadeCocosPerdidos,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FechamentoCaixaBloc>().quantidadeCocosPerdidosController,
                  onChanged: (value) { context.read<FechamentoCaixaBloc>()
                    .add(QuantidadeCocosPerdidosChanged(quantidadeCocosPerdidos:int.parse(value))); },
                  keyboardType:TextInputType.number,                  decoration: InputDecoration(
                      labelText:'quantidadeCocosPerdidos'));
            }
        );
      }
      Widget quantidadeCocosVendidosField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.quantidadeCocosVendidos != current.quantidadeCocosVendidos,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FechamentoCaixaBloc>().quantidadeCocosVendidosController,
                  onChanged: (value) { context.read<FechamentoCaixaBloc>()
                    .add(QuantidadeCocosVendidosChanged(quantidadeCocosVendidos:int.parse(value))); },
                  keyboardType:TextInputType.number,                  decoration: InputDecoration(
                      labelText:'quantidadeCocosVendidos'));
            }
        );
      }
      Widget quantidadeCocoSobrouField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.quantidadeCocoSobrou != current.quantidadeCocoSobrou,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FechamentoCaixaBloc>().quantidadeCocoSobrouController,
                  onChanged: (value) { context.read<FechamentoCaixaBloc>()
                    .add(QuantidadeCocoSobrouChanged(quantidadeCocoSobrou:int.parse(value))); },
                  keyboardType:TextInputType.number,                  decoration: InputDecoration(
                      labelText:'quantidadeCocoSobrou'));
            }
        );
      }
      Widget divididoPorField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.divididoPor != current.divididoPor,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FechamentoCaixaBloc>().divididoPorController,
                  onChanged: (value) { context.read<FechamentoCaixaBloc>()
                    .add(DivididoPorChanged(divididoPor:int.parse(value))); },
                  keyboardType:TextInputType.number,                  decoration: InputDecoration(
                      labelText:'divididoPor'));
            }
        );
      }
      Widget valorTotalCocoField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.valorTotalCoco != current.valorTotalCoco,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FechamentoCaixaBloc>().valorTotalCocoController,
                  onChanged: (value) { context.read<FechamentoCaixaBloc>()
                    .add(ValorTotalCocoChanged(valorTotalCoco:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valorTotalCoco'));
            }
        );
      }
      Widget valorTotalCocoPerdidoField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.valorTotalCocoPerdido != current.valorTotalCocoPerdido,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FechamentoCaixaBloc>().valorTotalCocoPerdidoController,
                  onChanged: (value) { context.read<FechamentoCaixaBloc>()
                    .add(ValorTotalCocoPerdidoChanged(valorTotalCocoPerdido:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valorTotalCocoPerdido'));
            }
        );
      }
      Widget valorPorPessoaField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.valorPorPessoa != current.valorPorPessoa,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FechamentoCaixaBloc>().valorPorPessoaController,
                  onChanged: (value) { context.read<FechamentoCaixaBloc>()
                    .add(ValorPorPessoaChanged(valorPorPessoa:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valorPorPessoa'));
            }
        );
      }
      Widget valorDespesasField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.valorDespesas != current.valorDespesas,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FechamentoCaixaBloc>().valorDespesasController,
                  onChanged: (value) { context.read<FechamentoCaixaBloc>()
                    .add(ValorDespesasChanged(valorDespesas:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valorDespesas'));
            }
        );
      }
      Widget valorDinheiroField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.valorDinheiro != current.valorDinheiro,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FechamentoCaixaBloc>().valorDinheiroController,
                  onChanged: (value) { context.read<FechamentoCaixaBloc>()
                    .add(ValorDinheiroChanged(valorDinheiro:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valorDinheiro'));
            }
        );
      }
      Widget valorCartaoField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.valorCartao != current.valorCartao,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FechamentoCaixaBloc>().valorCartaoController,
                  onChanged: (value) { context.read<FechamentoCaixaBloc>()
                    .add(ValorCartaoChanged(valorCartao:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valorCartao'));
            }
        );
      }
      Widget valorTotalField() {
        return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.valorTotal != current.valorTotal,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<FechamentoCaixaBloc>().valorTotalController,
                  onChanged: (value) { context.read<FechamentoCaixaBloc>()
                    .add(ValorTotalChanged(valorTotal:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'valorTotal'));
            }
        );
      }


  Widget validationZone() {
    return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(FechamentoCaixaState state, BuildContext context) {
    String notificationTranslated = '';
    Color? notificationColors;

    if (state.generalNotificationKey.toString().compareTo(HttpUtils.errorServerKey) == 0) {
      notificationTranslated ='Something wrong when calling the server, please try again';
      notificationColors = Theme.of(context).errorColor;
    } else if (state.generalNotificationKey.toString().compareTo(HttpUtils.badRequestServerKey) == 0) {
      notificationTranslated ='Something wrong happened with the received data';
      notificationColors = Theme.of(context).errorColor;
    }

    return Text(
      notificationTranslated,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
          color: notificationColors),
    );
  }

  submit(BuildContext context) {
    return BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
        buildWhen: (previous, current) => previous.isValid != current.isValid,
        builder: (context, state) {
          String buttonLabel = state.editMode == true ?
'Edit':
'Create';
          return ElevatedButton(
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Visibility(
                    replacement: CircularProgressIndicator(value: null),
                    visible: !state.formStatus.isInProgress,
                    child: Text(buttonLabel),
                  ),
                )),
            onPressed: state.isValid ? () => context.read<FechamentoCaixaBloc>().add(FechamentoCaixaFormSubmitted()) : null,
          );
        }
    );
  }
}
