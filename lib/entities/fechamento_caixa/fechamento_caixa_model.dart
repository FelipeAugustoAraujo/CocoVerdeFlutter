import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:time_machine/time_machine.dart';

import '../fechamento_caixa_detalhes/fechamento_caixa_detalhes_model.dart';

@jsonSerializable
class FechamentoCaixa {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'dataInicial', converterParams: {'format': 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\''})
  final Instant? dataInicial;

    @JsonProperty(name: 'dataFinal', converterParams: {'format': 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\''})
  final Instant? dataFinal;

    @JsonProperty(name: 'quantidadeCocosPerdidos')
  final int? quantidadeCocosPerdidos;

    @JsonProperty(name: 'quantidadeCocosVendidos')
  final int? quantidadeCocosVendidos;

    @JsonProperty(name: 'quantidadeCocoSobrou')
  final int? quantidadeCocoSobrou;

    @JsonProperty(name: 'divididoPor')
  final int? divididoPor;

    @JsonProperty(name: 'valorTotalCoco')
  final BigDecimal? valorTotalCoco;

    @JsonProperty(name: 'valorTotalCocoPerdido')
  final BigDecimal? valorTotalCocoPerdido;

    @JsonProperty(name: 'valorPorPessoa')
  final BigDecimal? valorPorPessoa;

    @JsonProperty(name: 'valorDespesas')
  final BigDecimal? valorDespesas;

    @JsonProperty(name: 'valorDinheiro')
  final BigDecimal? valorDinheiro;

    @JsonProperty(name: 'valorCartao')
  final BigDecimal? valorCartao;

    @JsonProperty(name: 'valorTotal')
  final BigDecimal? valorTotal;

  @JsonProperty(name: 'fechamentoCaixaDetalhes')
  final FechamentoCaixaDetalhes? fechamentoCaixaDetalhes;

 const FechamentoCaixa (
     this.id,
        this.dataInicial,
        this.dataFinal,
        this.quantidadeCocosPerdidos,
        this.quantidadeCocosVendidos,
        this.quantidadeCocoSobrou,
        this.divididoPor,
        this.valorTotalCoco,
        this.valorTotalCocoPerdido,
        this.valorPorPessoa,
        this.valorDespesas,
        this.valorDinheiro,
        this.valorCartao,
        this.valorTotal,
        this.fechamentoCaixaDetalhes,
    );



FechamentoCaixa.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                dataInicial= json['dataInicial'] == null ? null : Instant.dateTime(DateTime.parse(json['dataInicial']))
,
                dataFinal= json['dataFinal'] == null ? null : Instant.dateTime(DateTime.parse(json['dataFinal']))
,
                quantidadeCocosPerdidos= json['quantidadeCocosPerdidos']
,
                quantidadeCocosVendidos= json['quantidadeCocosVendidos']
,
                quantidadeCocoSobrou= json['quantidadeCocoSobrou']
,
                divididoPor= json['divididoPor']
,
                valorTotalCoco= json['valorTotalCoco']
,
                valorTotalCocoPerdido= json['valorTotalCocoPerdido']
,
                valorPorPessoa= json['valorPorPessoa']
,
                valorDespesas= json['valorDespesas']
,
                valorDinheiro= json['valorDinheiro']
,
                valorCartao= json['valorCartao']
,
                valorTotal= json['valorTotal']

,
                fechamentoCaixaDetalhes= json['fechamentoCaixaDetalhes'] == null ? null : FechamentoCaixaDetalhes.fromJson(json['fechamentoCaixaDetalhes'])
            
;

Map<String, dynamic> toJson() => {
    'id': id,
    'dataInicial': dataInicial,
    'dataFinal': dataFinal,
    'quantidadeCocosPerdidos': quantidadeCocosPerdidos,
    'quantidadeCocosVendidos': quantidadeCocosVendidos,
    'quantidadeCocoSobrou': quantidadeCocoSobrou,
    'divididoPor': divididoPor,
    'valorTotalCoco': valorTotalCoco,
    'valorTotalCocoPerdido': valorTotalCocoPerdido,
    'valorPorPessoa': valorPorPessoa,
    'valorDespesas': valorDespesas,
    'valorDinheiro': valorDinheiro,
    'valorCartao': valorCartao,
    'valorTotal': valorTotal
,
        'fechamentoCaixaDetalhes': fechamentoCaixaDetalhes};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
+
    ', "dataInicial": "$dataInicial"'
+
    ', "dataFinal": "$dataFinal"'
+
    ', "quantidadeCocosPerdidos": "$quantidadeCocosPerdidos"'
+
    ', "quantidadeCocosVendidos": "$quantidadeCocosVendidos"'
+
    ', "quantidadeCocoSobrou": "$quantidadeCocoSobrou"'
+
    ', "divididoPor": "$divididoPor"'
+
    ', "valorTotalCoco": "$valorTotalCoco"'
+
    ', "valorTotalCocoPerdido": "$valorTotalCocoPerdido"'
+
    ', "valorPorPessoa": "$valorPorPessoa"'
+
    ', "valorDespesas": "$valorDespesas"'
+
    ', "valorDinheiro": "$valorDinheiro"'
+
    ', "valorCartao": "$valorCartao"'
+
    ', "valorTotal": "$valorTotal"'
;
        if (fechamentoCaixaDetalhes!= null) out += ',"fechamentoCaixaDetalhes": $fechamentoCaixaDetalhes';
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is FechamentoCaixa &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


