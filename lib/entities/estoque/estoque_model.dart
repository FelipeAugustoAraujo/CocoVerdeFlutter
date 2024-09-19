import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:time_machine/time_machine.dart';

import '../produto/produto_model.dart';
import '../entrada_financeira/entrada_financeira_model.dart';
import '../saida_financeira/saida_financeira_model.dart';

@jsonSerializable
class Estoque {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'quantidade')
  final int? quantidade;

    @JsonProperty(name: 'criadoEm', converterParams: {'format': 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\''})
  final Instant? criadoEm;

    @JsonProperty(name: 'modificadoEm', converterParams: {'format': 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\''})
  final Instant? modificadoEm;

  @JsonProperty(name: 'produto')
  final Produto? produto;

  @JsonProperty(name: 'entradaFinanceira')
  final EntradaFinanceira? entradaFinanceira;

  @JsonProperty(name: 'saidaFinanceira')
  final SaidaFinanceira? saidaFinanceira;

 const Estoque (
     this.id,
        this.quantidade,
        this.criadoEm,
        this.modificadoEm,
        this.produto,
        this.entradaFinanceira,
        this.saidaFinanceira,
    );



Estoque.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                quantidade= json['quantidade']
,
                criadoEm= json['criadoEm'] == null ? null : Instant.dateTime(DateTime.parse(json['criadoEm']))
,
                modificadoEm= json['modificadoEm'] == null ? null : Instant.dateTime(DateTime.parse(json['modificadoEm']))

,
                produto= json['produto'] == null ? null : Produto.fromJson(json['produto'])
            
,
                entradaFinanceira= json['entradaFinanceira'] == null ? null : EntradaFinanceira.fromJson(json['entradaFinanceira'])
            
,
                saidaFinanceira= json['saidaFinanceira'] == null ? null : SaidaFinanceira.fromJson(json['saidaFinanceira'])
            
;

Map<String, dynamic> toJson() => {
    'id': id,
    'quantidade': quantidade,
    'criadoEm': criadoEm,
    'modificadoEm': modificadoEm
,
        'produto': produto,
        'entradaFinanceira': entradaFinanceira,
        'saidaFinanceira': saidaFinanceira};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
+
    ', "quantidade": "$quantidade"'
+
    ', "criadoEm": "$criadoEm"'
+
    ', "modificadoEm": "$modificadoEm"'
;
        if (produto!= null) out += ',"produto": $produto';
        if (entradaFinanceira!= null) out += ',"entradaFinanceira": $entradaFinanceira';
        if (saidaFinanceira!= null) out += ',"saidaFinanceira": $saidaFinanceira';
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Estoque &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


