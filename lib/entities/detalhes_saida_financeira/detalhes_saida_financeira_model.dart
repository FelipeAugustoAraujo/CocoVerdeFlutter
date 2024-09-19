import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:time_machine/time_machine.dart';


@jsonSerializable
class DetalhesSaidaFinanceira {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'quantidadeItem')
  final int? quantidadeItem;

    @JsonProperty(name: 'valor')
  final BigDecimal? valor;

 const DetalhesSaidaFinanceira (
     this.id,
        this.quantidadeItem,
        this.valor,
    );



DetalhesSaidaFinanceira.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                quantidadeItem= json['quantidadeItem']
,
                valor= json['valor']

;

Map<String, dynamic> toJson() => {
    'id': id,
    'quantidadeItem': quantidadeItem,
    'valor': valor
};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
+
    ', "quantidadeItem": "$quantidadeItem"'
+
    ', "valor": "$valor"'
;
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is DetalhesSaidaFinanceira &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


