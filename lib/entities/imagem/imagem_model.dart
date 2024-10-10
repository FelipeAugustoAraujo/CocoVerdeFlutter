import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../saida_financeira/saida_financeira_model.dart';
import '../entrada_financeira/entrada_financeira_model.dart';

@jsonSerializable
class Imagem {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'name')
  final String? name;

    @JsonProperty(name: 'contentType')
  final String? contentType;

    @JsonProperty(name: 'description')
  final String? description;

  @JsonProperty(name: 'saidaFinanceira')
  final SaidaFinanceira? saidaFinanceira;

  @JsonProperty(name: 'entradaFinanceira')
  final EntradaFinanceira? entradaFinanceira;

 const Imagem (
     this.id,
        this.name,
        this.contentType,
        this.description,
        this.saidaFinanceira,
        this.entradaFinanceira,
    );



Imagem.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                name= json['name']
,
                contentType= json['contentType']
,
                description= json['description']

,
                saidaFinanceira= json['saidaFinanceira'] == null ? null : SaidaFinanceira.fromJson(json['saidaFinanceira'])
            
,
                entradaFinanceira= json['entradaFinanceira'] == null ? null : EntradaFinanceira.fromJson(json['entradaFinanceira'])
            
;

Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'contentType': contentType,
    'description': description
,
        'saidaFinanceira': saidaFinanceira,
        'entradaFinanceira': entradaFinanceira};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
+
    ', "name": "$name"'
+
    ', "contentType": "$contentType"'
+
    ', "description": "$description"'
;
        if (saidaFinanceira!= null) out += ',"saidaFinanceira": $saidaFinanceira';
        if (entradaFinanceira!= null) out += ',"entradaFinanceira": $entradaFinanceira';
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Imagem &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


