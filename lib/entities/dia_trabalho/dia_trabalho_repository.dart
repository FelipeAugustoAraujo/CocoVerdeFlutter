import 'dart:convert';
import 'package:cocoverde/entities/dia_trabalho/dia_trabalho_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class DiaTrabalhoRepository {
    DiaTrabalhoRepository();

  static final String uriEndpoint = '/dia-trabalhos';

  Future<List<DiaTrabalho>> getAllDiaTrabalhos() async {
    final allDiaTrabalhosRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allDiaTrabalhosRequest.body);
    List<DiaTrabalho> diaTrabalhos = List<DiaTrabalho>.from(l.map((model)=> DiaTrabalho.fromJson(model)));
    return diaTrabalhos;
  }


  Future<DiaTrabalho> getDiaTrabalho(int? id) async {
    final diaTrabalhoRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return DiaTrabalho.fromJson(json.decode(diaTrabalhoRequest.body));
  }

  Future<DiaTrabalho> create(DiaTrabalho diaTrabalho) async {
    final diaTrabalhoRequest = await HttpUtils.postRequest('$uriEndpoint', diaTrabalho.toString());
    return DiaTrabalho.fromJson(json.decode(diaTrabalhoRequest.body));
  }

  Future<DiaTrabalho> update(DiaTrabalho diaTrabalho) async {
    final diaTrabalhoRequest = await HttpUtils.putRequest('$uriEndpoint', diaTrabalho.toString(), diaTrabalho.id!);
    return DiaTrabalho.fromJson(json.decode(diaTrabalhoRequest.body));
  }

  Future<void> delete(int id) async {
    final diaTrabalhoRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
