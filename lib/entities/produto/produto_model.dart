import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../estoque/estoque_model.dart';
import '../frente/frente_model.dart';
import '../detalhes_entrada_financeira/detalhes_entrada_financeira_model.dart';
import '../fornecedor/fornecedor_model.dart';

@jsonSerializable
class Produto {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'nome')
  final String? nome;

    @JsonProperty(name: 'descricao')
  final String? descricao;

    @JsonProperty(name: 'valorBase')
  final String? valorBase;

  @JsonProperty(name: 'estoque')
  final Estoque? estoque;

  @JsonProperty(name: 'frente')
  final Frente? frente;

  @JsonProperty(name: 'detalhesEntradaFinanceira')
  final DetalhesEntradaFinanceira? detalhesEntradaFinanceira;

  @JsonProperty(name: 'fornecedor')
  final Fornecedor? fornecedor;

 const Produto (
     this.id,
        this.nome,
        this.descricao,
        this.valorBase,
        this.estoque,
        this.frente,
        this.detalhesEntradaFinanceira,
        this.fornecedor,
    );



Produto.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                nome= json['nome']
,
                descricao= json['descricao']
,
                valorBase= json['valorBase']

,
                estoque= json['estoque'] == null ? null : Estoque.fromJson(json['estoque'])
            
,
                frente= json['frente'] == null ? null : Frente.fromJson(json['frente'])
            
,
                detalhesEntradaFinanceira= json['detalhesEntradaFinanceira'] == null ? null : DetalhesEntradaFinanceira.fromJson(json['detalhesEntradaFinanceira'])
            
,
                fornecedor= json['fornecedor'] == null ? null : Fornecedor.fromJson(json['fornecedor'])
            
;

Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'descricao': descricao,
    'valorBase': valorBase
,
        'estoque': estoque,
        'frente': frente,
        'detalhesEntradaFinanceira': detalhesEntradaFinanceira,
        'fornecedor': fornecedor};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
+
    ', "nome": "$nome"'
+
    ', "descricao": "$descricao"'
+
    ', "valorBase": "$valorBase"'
;
        if (estoque!= null) out += ',"estoque": $estoque';
        if (frente!= null) out += ',"frente": $frente';
        if (detalhesEntradaFinanceira!= null) out += ',"detalhesEntradaFinanceira": $detalhesEntradaFinanceira';
        if (fornecedor!= null) out += ',"fornecedor": $fornecedor';
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Produto &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


