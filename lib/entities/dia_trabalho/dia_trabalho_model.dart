import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:time_machine/time_machine.dart';


@jsonSerializable
class DiaTrabalho {

  @JsonProperty(name: 'id')
  final int? id;

    @JsonProperty(name: 'data', converterParams: {'format': 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\''})
  final Instant? data;

 const DiaTrabalho (
     this.id,
        this.data,
    );



DiaTrabalho.fromJson(Map<String, dynamic> json)
    : id= json['id']
,
                data= json['data'] == null ? null : Instant.dateTime(DateTime.parse(json['data']))

;

Map<String, dynamic> toJson() => {
    'id': id,
    'data': data
};

@override
String toString() {
    String out = '{';
    out += '"id": ${id!= null ? id: null}'
+
    ', "data": "$data"'
;
    out += '}';
    return out;
   }

@override
bool operator == (Object other) =>
    identical(this, other) ||
    other is DiaTrabalho &&
    id == other.id ;


@override
int get hashCode =>
    id.hashCode ;
}


