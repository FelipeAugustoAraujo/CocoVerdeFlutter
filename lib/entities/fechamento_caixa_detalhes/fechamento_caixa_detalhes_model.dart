import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:time_machine/time_machine.dart';

import '../fechamento_caixa/fechamento_caixa_model.dart';
import '../entrada_financeira/entrada_financeira_model.dart';
import '../saida_financeira/saida_financeira_model.dart';

@jsonSerializable
class FechamentoCaixaDetalhes {

  @JsonProperty(name: 'id')
  final int? id;

  @JsonProperty(name: 'fechamentoCaixa')
  final FechamentoCaixa? fechamentoCaixa;

  @JsonProperty(name: 'entradaFinanceira')
  final EntradaFinanceira? entradaFinanceira;

  @JsonProperty(name: 'saidaFinanceira')
  final SaidaFinanceira? saidaFinanceira;

 const FechamentoCaixaDetalhes (
     this.id,
        this.fechamentoCaixa,
        this.entradaFinanceira,
        this.saidaFinanceira,
    );



FechamentoCaixaDetalhes.fromJson(Map<String, dynamic> json)
    : id= json['id']

,
                fechamentoCaixa= json['fechamentoCaixa'] == null ? null : FechamentoCaixa.fromJson(json['fechamentoCaixa'])
            
,
                entradaFinanceira= json['entradaFinanceira'] == null ? null : EntradaFinanceira.fromJson(json['entradaFinanceira'])
            
,
                saidaFinanceira= json['saidaFinanceira'] == null ? null : SaidaFinanceira.fromJson(json['saidaFinanceira'])
            
;

Map<String, dynamic> toJson() => {
    'id': id
,
        'fechamentoCaixa': fechamentoCaixa,
        'entradaFinanceira': entradaFinanceira,
        'saidaFinanceira': saidaFinanceira};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
;
        if (fechamentoCaixa!= null) out += ',"fechamentoCaixa": $fechamentoCaixa';
        if (entradaFinanceira!= null) out += ',"entradaFinanceira": $entradaFinanceira';
        if (saidaFinanceira!= null) out += ',"saidaFinanceira": $saidaFinanceira';
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is FechamentoCaixaDetalhes &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


