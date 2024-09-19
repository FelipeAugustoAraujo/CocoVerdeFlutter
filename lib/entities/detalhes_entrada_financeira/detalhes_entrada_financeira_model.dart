import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:time_machine/time_machine.dart';

import '../produto/produto_model.dart';
import '../entrada_financeira/entrada_financeira_model.dart';

@jsonSerializable
class DetalhesEntradaFinanceira {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'quantidadeItem')
  final int? quantidadeItem;

    @JsonProperty(name: 'valor')
  final BigDecimal? valor;

  @JsonProperty(name: 'produto')
  final Produto? produto;

  @JsonProperty(name: 'entradaFinanceira')
  final EntradaFinanceira? entradaFinanceira;

 const DetalhesEntradaFinanceira (
     this.id,
        this.quantidadeItem,
        this.valor,
        this.produto,
        this.entradaFinanceira,
    );



DetalhesEntradaFinanceira.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                quantidadeItem= json['quantidadeItem']
,
                valor= json['valor']

,
                produto= json['produto'] == null ? null : Produto.fromJson(json['produto'])
            
,
                entradaFinanceira= json['entradaFinanceira'] == null ? null : EntradaFinanceira.fromJson(json['entradaFinanceira'])
            
;

Map<String, dynamic> toJson() => {
    'id': id,
    'quantidadeItem': quantidadeItem,
    'valor': valor
,
        'produto': produto,
        'entradaFinanceira': entradaFinanceira};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
+
    ', "quantidadeItem": "$quantidadeItem"'
+
    ', "valor": "$valor"'
;
        if (produto!= null) out += ',"produto": $produto';
        if (entradaFinanceira!= null) out += ',"entradaFinanceira": $entradaFinanceira';
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is DetalhesEntradaFinanceira &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


