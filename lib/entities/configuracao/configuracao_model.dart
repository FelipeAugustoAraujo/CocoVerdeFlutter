import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:time_machine/time_machine.dart';


@jsonSerializable
class Configuracao {

  @JsonProperty(name: 'id')
  final int? id;

 const Configuracao (
     this.id,
    );



Configuracao.fromJson(Map<String, dynamic> json)
    : id= json['id']

;

Map<String, dynamic> toJson() => {
    'id': id
};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
;
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is Configuracao &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


