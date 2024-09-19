import 'dart:convert';
import 'package:cocoverde/entities/fechamento_caixa_detalhes/fechamento_caixa_detalhes_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class FechamentoCaixaDetalhesRepository {
    FechamentoCaixaDetalhesRepository();

  static final String uriEndpoint = '/fechamento-caixa-detalhes';

  Future<List<FechamentoCaixaDetalhes>> getAllFechamentoCaixaDetalhes() async {
    final allFechamentoCaixaDetalhesRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allFechamentoCaixaDetalhesRequest.body);
    List<FechamentoCaixaDetalhes> fechamentoCaixaDetalhes = List<FechamentoCaixaDetalhes>.from(l.map((model)=> FechamentoCaixaDetalhes.fromJson(model)));
    return fechamentoCaixaDetalhes;
  }


      Future<List<FechamentoCaixaDetalhes>> getAllFechamentoCaixaDetalhesListByFechamentoCaixa(int fechamentoCaixaId) async {
        final allFechamentoCaixaDetalhesRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&fechamentoCaixaId.in=$fechamentoCaixaId&sort=id,asc');
        Iterable l = json.decode(allFechamentoCaixaDetalhesRequest.body);
        List<FechamentoCaixaDetalhes> fechamentoCaixaDetalhes = List<FechamentoCaixaDetalhes>.from(l.map((model)=> FechamentoCaixaDetalhes.fromJson(model)));
        return fechamentoCaixaDetalhes;
      }

      Future<List<FechamentoCaixaDetalhes>> getAllFechamentoCaixaDetalhesListByEntradaFinanceira(int entradaFinanceiraId) async {
        final allFechamentoCaixaDetalhesRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&entradaFinanceiraId.in=$entradaFinanceiraId&sort=id,asc');
        Iterable l = json.decode(allFechamentoCaixaDetalhesRequest.body);
        List<FechamentoCaixaDetalhes> fechamentoCaixaDetalhes = List<FechamentoCaixaDetalhes>.from(l.map((model)=> FechamentoCaixaDetalhes.fromJson(model)));
        return fechamentoCaixaDetalhes;
      }

      Future<List<FechamentoCaixaDetalhes>> getAllFechamentoCaixaDetalhesListBySaidaFinanceira(int saidaFinanceiraId) async {
        final allFechamentoCaixaDetalhesRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&saidaFinanceiraId.in=$saidaFinanceiraId&sort=id,asc');
        Iterable l = json.decode(allFechamentoCaixaDetalhesRequest.body);
        List<FechamentoCaixaDetalhes> fechamentoCaixaDetalhes = List<FechamentoCaixaDetalhes>.from(l.map((model)=> FechamentoCaixaDetalhes.fromJson(model)));
        return fechamentoCaixaDetalhes;
      }

  Future<FechamentoCaixaDetalhes> getFechamentoCaixaDetalhes(int? id) async {
    final fechamentoCaixaDetalhesRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return FechamentoCaixaDetalhes.fromJson(json.decode(fechamentoCaixaDetalhesRequest.body));
  }

  Future<FechamentoCaixaDetalhes> create(FechamentoCaixaDetalhes fechamentoCaixaDetalhes) async {
    final fechamentoCaixaDetalhesRequest = await HttpUtils.postRequest('$uriEndpoint', fechamentoCaixaDetalhes.toString());
    return FechamentoCaixaDetalhes.fromJson(json.decode(fechamentoCaixaDetalhesRequest.body));
  }

  Future<FechamentoCaixaDetalhes> update(FechamentoCaixaDetalhes fechamentoCaixaDetalhes) async {
    final fechamentoCaixaDetalhesRequest = await HttpUtils.putRequest('$uriEndpoint', fechamentoCaixaDetalhes.toString(), fechamentoCaixaDetalhes.id!);
    return FechamentoCaixaDetalhes.fromJson(json.decode(fechamentoCaixaDetalhesRequest.body));
  }

  Future<void> delete(int id) async {
    final fechamentoCaixaDetalhesRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
