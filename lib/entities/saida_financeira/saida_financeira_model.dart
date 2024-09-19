import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:time_machine/time_machine.dart';

import '../estoque/estoque_model.dart';
import '../frente/frente_model.dart';
import '../fechamento_caixa_detalhes/fechamento_caixa_detalhes_model.dart';
import '../imagem/imagem_model.dart';

@jsonSerializable
class SaidaFinanceira {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'data', converterParams: {'format': 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\''})
  final Instant? data;

    @JsonProperty(name: 'valorTotal')
  final BigDecimal? valorTotal;

    @JsonProperty(name: 'descricao')
  final String? descricao;

    @JsonProperty(name: 'metodoPagamento')
  final MetodoPagamento? metodoPagamento;

    @JsonProperty(name: 'statusPagamento')
  final StatusPagamento? statusPagamento;

    @JsonProperty(name: 'responsavelPagamento')
  final ResponsavelPagamento? responsavelPagamento;

  @JsonProperty(name: 'estoque')
  final Estoque? estoque;

  @JsonProperty(name: 'frente')
  final Frente? frente;

  @JsonProperty(name: 'fechamentoCaixaDetalhes')
  final FechamentoCaixaDetalhes? fechamentoCaixaDetalhes;

  @JsonProperty(name: 'imagem')
  final Imagem? imagem;

 const SaidaFinanceira (
     this.id,
        this.data,
        this.valorTotal,
        this.descricao,
        this.metodoPagamento,
        this.statusPagamento,
        this.responsavelPagamento,
        this.estoque,
        this.frente,
        this.fechamentoCaixaDetalhes,
        this.imagem,
    );



SaidaFinanceira.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                data= json['data'] == null ? null : Instant.dateTime(DateTime.parse(json['data']))
,
                valorTotal= json['valorTotal']
,
                descricao= json['descricao']
,
                metodoPagamento= json['metodoPagamento']
,
                statusPagamento= json['statusPagamento']
,
                responsavelPagamento= json['responsavelPagamento']

,
                estoque= json['estoque'] == null ? null : Estoque.fromJson(json['estoque'])
            
,
                frente= json['frente'] == null ? null : Frente.fromJson(json['frente'])
            
,
                fechamentoCaixaDetalhes= json['fechamentoCaixaDetalhes'] == null ? null : FechamentoCaixaDetalhes.fromJson(json['fechamentoCaixaDetalhes'])
            
,
                imagem= json['imagem'] == null ? null : Imagem.fromJson(json['imagem'])
            
;

Map<String, dynamic> toJson() => {
    'id': id,
    'data': data,
    'valorTotal': valorTotal,
    'descricao': descricao,
    'metodoPagamento': metodoPagamento,
    'statusPagamento': statusPagamento,
    'responsavelPagamento': responsavelPagamento
,
        'estoque': estoque,
        'frente': frente,
        'fechamentoCaixaDetalhes': fechamentoCaixaDetalhes,
        'imagem': imagem};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
+
    ', "data": "$data"'
+
    ', "valorTotal": "$valorTotal"'
+
    ', "descricao": "$descricao"'
+
    ', "metodoPagamento": "$metodoPagamento"'
+
    ', "statusPagamento": "$statusPagamento"'
+
    ', "responsavelPagamento": "$responsavelPagamento"'
;
        if (estoque!= null) out += ',"estoque": $estoque';
        if (frente!= null) out += ',"frente": $frente';
        if (fechamentoCaixaDetalhes!= null) out += ',"fechamentoCaixaDetalhes": $fechamentoCaixaDetalhes';
        if (imagem!= null) out += ',"imagem": $imagem';
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is SaidaFinanceira &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


@jsonSerializable
enum MetodoPagamento {
    DINHEIRO ,
    CARTAO_DEBITO ,
    CARTAO_CREDITO ,
    PIX ,
    TRANSFERENCIA 
}@jsonSerializable
enum StatusPagamento {
    PAGO ,
    NAO_PAGO 
}@jsonSerializable
enum ResponsavelPagamento {
    BARRACA ,
    CHEFE ,
    FELIPE_GISELLE 
}