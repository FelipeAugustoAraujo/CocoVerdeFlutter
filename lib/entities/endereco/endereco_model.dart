import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../fornecedor/fornecedor_model.dart';
import '../funcionario/funcionario_model.dart';
import '../cliente/cliente_model.dart';
import '../cidade/cidade_model.dart';

@jsonSerializable
class Endereco {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'cep')
  final String? cep;

    @JsonProperty(name: 'logradouro')
  final String? logradouro;

    @JsonProperty(name: 'numero')
  final int? numero;

    @JsonProperty(name: 'complemento')
  final String? complemento;

    @JsonProperty(name: 'bairro')
  final String? bairro;

  @JsonProperty(name: 'fornecedor')
  final Fornecedor? fornecedor;

  @JsonProperty(name: 'funcionario')
  final Funcionario? funcionario;

  @JsonProperty(name: 'cliente')
  final Cliente? cliente;

  @JsonProperty(name: 'cidade')
  final Cidade? cidade;

 const Endereco (
     this.id,
        this.cep,
        this.logradouro,
        this.numero,
        this.complemento,
        this.bairro,
        this.fornecedor,
        this.funcionario,
        this.cliente,
        this.cidade,
    );



Endereco.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                cep= json['cep']
,
                logradouro= json['logradouro']
,
                numero= json['numero']
,
                complemento= json['complemento']
,
                bairro= json['bairro']

,
                fornecedor= json['fornecedor'] == null ? null : Fornecedor.fromJson(json['fornecedor'])
            
,
                funcionario= json['funcionario'] == null ? null : Funcionario.fromJson(json['funcionario'])
            
,
                cliente= json['cliente'] == null ? null : Cliente.fromJson(json['cliente'])
            
,
                cidade= json['cidade'] == null ? null : Cidade.fromJson(json['cidade'])
            
;

Map<String, dynamic> toJson() => {
    'id': id,
    'cep': cep,
    'logradouro': logradouro,
    'numero': numero,
    'complemento': complemento,
    'bairro': bairro
,
        'fornecedor': fornecedor,
        'funcionario': funcionario,
        'cliente': cliente,
        'cidade': cidade};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
+
    ', "cep": "$cep"'
+
    ', "logradouro": "$logradouro"'
+
    ', "numero": "$numero"'
+
    ', "complemento": "$complemento"'
+
    ', "bairro": "$bairro"'
;
        if (fornecedor!= null) out += ',"fornecedor": $fornecedor';
        if (funcionario!= null) out += ',"funcionario": $funcionario';
        if (cliente!= null) out += ',"cliente": $cliente';
        if (cidade!= null) out += ',"cidade": $cidade';
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Endereco &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


