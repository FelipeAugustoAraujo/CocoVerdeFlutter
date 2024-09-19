import 'dart:convert';
import 'package:cocoverde/entities/fechamento_caixa/fechamento_caixa_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class FechamentoCaixaRepository {
    FechamentoCaixaRepository();

  static final String uriEndpoint = '/fechamento-caixas';

  Future<List<FechamentoCaixa>> getAllFechamentoCaixas() async {
    final allFechamentoCaixasRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allFechamentoCaixasRequest.body);
    List<FechamentoCaixa> fechamentoCaixas = List<FechamentoCaixa>.from(l.map((model)=> FechamentoCaixa.fromJson(model)));
    return fechamentoCaixas;
  }


      Future<List<FechamentoCaixa>> getAllFechamentoCaixaListByFechamentoCaixaDetalhes(int fechamentoCaixaDetalhesId) async {
        final allFechamentoCaixasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&fechamentoCaixaDetalhesId.in=$fechamentoCaixaDetalhesId&sort=id,asc');
        Iterable l = json.decode(allFechamentoCaixasRequest.body);
        List<FechamentoCaixa> fechamentoCaixas = List<FechamentoCaixa>.from(l.map((model)=> FechamentoCaixa.fromJson(model)));
        return fechamentoCaixas;
      }

  Future<FechamentoCaixa> getFechamentoCaixa(int? id) async {
    final fechamentoCaixaRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return FechamentoCaixa.fromJson(json.decode(fechamentoCaixaRequest.body));
  }

  Future<FechamentoCaixa> create(FechamentoCaixa fechamentoCaixa) async {
    final fechamentoCaixaRequest = await HttpUtils.postRequest('$uriEndpoint', fechamentoCaixa.toString());
    return FechamentoCaixa.fromJson(json.decode(fechamentoCaixaRequest.body));
  }

  Future<FechamentoCaixa> update(FechamentoCaixa fechamentoCaixa) async {
    final fechamentoCaixaRequest = await HttpUtils.putRequest('$uriEndpoint', fechamentoCaixa.toString(), fechamentoCaixa.id!);
    return FechamentoCaixa.fromJson(json.decode(fechamentoCaixaRequest.body));
  }

  Future<void> delete(int id) async {
    final fechamentoCaixaRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
