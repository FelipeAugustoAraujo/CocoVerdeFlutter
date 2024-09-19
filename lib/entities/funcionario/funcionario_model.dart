import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:time_machine/time_machine.dart';

import '../endereco/endereco_model.dart';

@jsonSerializable
class Funcionario {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'nome')
  final String? nome;

    @JsonProperty(name: 'dataNascimento')
  final String? dataNascimento;

    @JsonProperty(name: 'identificador')
  final String? identificador;

    @JsonProperty(name: 'telefone')
  final String? telefone;

    @JsonProperty(name: 'dataCadastro', converterParams: {'format': 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\''})
  final Instant? dataCadastro;

    @JsonProperty(name: 'valorBase')
  final BigDecimal? valorBase;

  @JsonProperty(name: 'endereco')
  final Endereco? endereco;

 const Funcionario (
     this.id,
        this.nome,
        this.dataNascimento,
        this.identificador,
        this.telefone,
        this.dataCadastro,
        this.valorBase,
        this.endereco,
    );



Funcionario.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                nome= json['nome']
,
                dataNascimento= json['dataNascimento']
,
                identificador= json['identificador']
,
                telefone= json['telefone']
,
                dataCadastro= json['dataCadastro'] == null ? null : Instant.dateTime(DateTime.parse(json['dataCadastro']))
,
                valorBase= json['valorBase']

,
                endereco= json['endereco'] == null ? null : Endereco.fromJson(json['endereco'])
            
;

Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'dataNascimento': dataNascimento,
    'identificador': identificador,
    'telefone': telefone,
    'dataCadastro': dataCadastro,
    'valorBase': valorBase
,
        'endereco': endereco};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
+
    ', "nome": "$nome"'
+
    ', "dataNascimento": "$dataNascimento"'
+
    ', "identificador": "$identificador"'
+
    ', "telefone": "$telefone"'
+
    ', "dataCadastro": "$dataCadastro"'
+
    ', "valorBase": "$valorBase"'
;
        if (endereco!= null) out += ',"endereco": $endereco';
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Funcionario &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


