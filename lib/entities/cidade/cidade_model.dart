import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:time_machine/time_machine.dart';

import '../endereco/endereco_model.dart';

@jsonSerializable
class Cidade {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'nome')
  final String? nome;

    @JsonProperty(name: 'estado')
  final Estado? estado;

  @JsonProperty(name: 'endereco')
  final Endereco? endereco;

 const Cidade (
     this.id,
        this.nome,
        this.estado,
        this.endereco,
    );



Cidade.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                nome= json['nome']
,
                estado= json['estado']

,
                endereco= json['endereco'] == null ? null : Endereco.fromJson(json['endereco'])
            
;

Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'estado': estado
,
        'endereco': endereco};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
+
    ', "nome": "$nome"'
+
    ', "estado": "$estado"'
;
        if (endereco!= null) out += ',"endereco": $endereco';
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Cidade &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


@jsonSerializable
enum Estado {
    ACRE (Acre) ,
    ALAGOAS (Alagoas) ,
    AMAPA (Amapá) ,
    AMAZONAS (Amazonas) ,
    BAHIA (Bahia) ,
    CEARA (Ceará) ,
    DISTRITO_FEDERAL (Distrito Federal) ,
    ESPIRITO_SANTO (Espírito Santo) ,
    GOIAS (Goiás) ,
    MARANHAO (Maranhão) ,
    MATO_GROSSO (Mato Grosso) ,
    MATO_GROSSO_DO_SUL (Mato Grosso do Sul) ,
    MINAS_GERAIS (Minas Gerais) ,
    PARA (Pará) ,
    PARAIBA (Paraíba) ,
    PARANA (Paraná) ,
    PERNAMBUCO (Pernambuco) ,
    PIAUI (Piauí) ,
    RIO_DE_JANEIRO (Rio de Janeiro) ,
    RIO_GRANDE_DO_NORTE (Rio Grande do Norte) ,
    RIO_GRANDE_DO_SUL (Rio Grande do Sul) ,
    RONDONIA (Rondônia) ,
    RORAIMA (Roraima) ,
    SANTA_CATARINA (Santa Catarina) ,
    SAO_PAULO (São Paulo) ,
    SERGIPE (Sergipe) ,
    TOCANTINS (Tocantins) 
}