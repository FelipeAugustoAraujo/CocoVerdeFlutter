import 'dart:convert';
import 'package:cocoverde/entities/detalhes_entrada_financeira/detalhes_entrada_financeira_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class DetalhesEntradaFinanceiraRepository {
    DetalhesEntradaFinanceiraRepository();

  static final String uriEndpoint = '/detalhes-entrada-financeiras';

  Future<List<DetalhesEntradaFinanceira>> getAllDetalhesEntradaFinanceiras() async {
    final allDetalhesEntradaFinanceirasRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allDetalhesEntradaFinanceirasRequest.body);
    List<DetalhesEntradaFinanceira> detalhesEntradaFinanceiras = List<DetalhesEntradaFinanceira>.from(l.map((model)=> DetalhesEntradaFinanceira.fromJson(model)));
    return detalhesEntradaFinanceiras;
  }


      Future<List<DetalhesEntradaFinanceira>> getAllDetalhesEntradaFinanceiraListByProduto(int produtoId) async {
        final allDetalhesEntradaFinanceirasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&produtoId.in=$produtoId&sort=id,asc');
        Iterable l = json.decode(allDetalhesEntradaFinanceirasRequest.body);
        List<DetalhesEntradaFinanceira> detalhesEntradaFinanceiras = List<DetalhesEntradaFinanceira>.from(l.map((model)=> DetalhesEntradaFinanceira.fromJson(model)));
        return detalhesEntradaFinanceiras;
      }

      Future<List<DetalhesEntradaFinanceira>> getAllDetalhesEntradaFinanceiraListByEntradaFinanceira(int entradaFinanceiraId) async {
        final allDetalhesEntradaFinanceirasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&entradaFinanceiraId.in=$entradaFinanceiraId&sort=id,asc');
        Iterable l = json.decode(allDetalhesEntradaFinanceirasRequest.body);
        List<DetalhesEntradaFinanceira> detalhesEntradaFinanceiras = List<DetalhesEntradaFinanceira>.from(l.map((model)=> DetalhesEntradaFinanceira.fromJson(model)));
        return detalhesEntradaFinanceiras;
      }

  Future<DetalhesEntradaFinanceira> getDetalhesEntradaFinanceira(int? id) async {
    final detalhesEntradaFinanceiraRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return DetalhesEntradaFinanceira.fromJson(json.decode(detalhesEntradaFinanceiraRequest.body));
  }

  Future<DetalhesEntradaFinanceira> create(DetalhesEntradaFinanceira detalhesEntradaFinanceira) async {
    final detalhesEntradaFinanceiraRequest = await HttpUtils.postRequest('$uriEndpoint', detalhesEntradaFinanceira.toString());
    return DetalhesEntradaFinanceira.fromJson(json.decode(detalhesEntradaFinanceiraRequest.body));
  }

  Future<DetalhesEntradaFinanceira> update(DetalhesEntradaFinanceira detalhesEntradaFinanceira) async {
    final detalhesEntradaFinanceiraRequest = await HttpUtils.putRequest('$uriEndpoint', detalhesEntradaFinanceira.toString(), detalhesEntradaFinanceira.id!);
    return DetalhesEntradaFinanceira.fromJson(json.decode(detalhesEntradaFinanceiraRequest.body));
  }

  Future<void> delete(int id) async {
    final detalhesEntradaFinanceiraRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
