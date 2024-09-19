import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:time_machine/time_machine.dart';

import '../produto/produto_model.dart';
import '../endereco/endereco_model.dart';
import '../entrada_financeira/entrada_financeira_model.dart';

@jsonSerializable
class Fornecedor {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'nome')
  final String? nome;

    @JsonProperty(name: 'identificador')
  final String? identificador;

    @JsonProperty(name: 'telefone')
  final String? telefone;

    @JsonProperty(name: 'dataCadastro', converterParams: {'format': 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\''})
  final Instant? dataCadastro;

  @JsonProperty(name: 'produto')
  final Produto? produto;

  @JsonProperty(name: 'endereco')
  final Endereco? endereco;

  @JsonProperty(name: 'entradaFinanceira')
  final EntradaFinanceira? entradaFinanceira;

 const Fornecedor (
     this.id,
        this.nome,
        this.identificador,
        this.telefone,
        this.dataCadastro,
        this.produto,
        this.endereco,
        this.entradaFinanceira,
    );



Fornecedor.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                nome= json['nome']
,
                identificador= json['identificador']
,
                telefone= json['telefone']
,
                dataCadastro= json['dataCadastro'] == null ? null : Instant.dateTime(DateTime.parse(json['dataCadastro']))

,
                produto= json['produto'] == null ? null : Produto.fromJson(json['produto'])
            
,
                endereco= json['endereco'] == null ? null : Endereco.fromJson(json['endereco'])
            
,
                entradaFinanceira= json['entradaFinanceira'] == null ? null : EntradaFinanceira.fromJson(json['entradaFinanceira'])
            
;

Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'identificador': identificador,
    'telefone': telefone,
    'dataCadastro': dataCadastro
,
        'produto': produto,
        'endereco': endereco,
        'entradaFinanceira': entradaFinanceira};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
+
    ', "nome": "$nome"'
+
    ', "identificador": "$identificador"'
+
    ', "telefone": "$telefone"'
+
    ', "dataCadastro": "$dataCadastro"'
;
        if (produto!= null) out += ',"produto": $produto';
        if (endereco!= null) out += ',"endereco": $endereco';
        if (entradaFinanceira!= null) out += ',"entradaFinanceira": $entradaFinanceira';
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Fornecedor &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


