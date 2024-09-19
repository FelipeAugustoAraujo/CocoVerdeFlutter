import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:time_machine/time_machine.dart';

import '../endereco/endereco_model.dart';

@jsonSerializable
class Cliente {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'nome')
  final String? nome;

    @JsonProperty(name: 'dataNascimento')
  final String? dataNascimento;

    @JsonProperty(name: 'identificador')
  final String? identificador;

    @JsonProperty(name: 'dataCadastro', converterParams: {'format': 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\''})
  final Instant? dataCadastro;

    @JsonProperty(name: 'telefone')
  final String? telefone;

  @JsonProperty(name: 'endereco')
  final Endereco? endereco;

 const Cliente (
     this.id,
        this.nome,
        this.dataNascimento,
        this.identificador,
        this.dataCadastro,
        this.telefone,
        this.endereco,
    );



Cliente.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                nome= json['nome']
,
                dataNascimento= json['dataNascimento']
,
                identificador= json['identificador']
,
                dataCadastro= json['dataCadastro'] == null ? null : Instant.dateTime(DateTime.parse(json['dataCadastro']))
,
                telefone= json['telefone']

,
                endereco= json['endereco'] == null ? null : Endereco.fromJson(json['endereco'])
            
;

Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'dataNascimento': dataNascimento,
    'identificador': identificador,
    'dataCadastro': dataCadastro,
    'telefone': telefone
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
    ', "dataCadastro": "$dataCadastro"'
+
    ', "telefone": "$telefone"'
;
        if (endereco!= null) out += ',"endereco": $endereco';
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Cliente &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


