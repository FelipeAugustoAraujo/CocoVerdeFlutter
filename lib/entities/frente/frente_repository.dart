import 'dart:convert';
import 'package:Cocoverde/entities/frente/frente_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';

class FrenteRepository {
    FrenteRepository();

  static final String uriEndpoint = '/frentes';

  Future<List<Frente>> getAllFrentes() async {
    final allFrentesRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allFrentesRequest.body);
    List<Frente> frentes = List<Frente>.from(l.map((model)=> Frente.fromJson(model)));
    return frentes;
  }


      Future<List<Frente>> getAllFrenteListByProduto(int produtoId) async {
        final allFrentesRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&produtoId.in=$produtoId&sort=id,asc');
        Iterable l = json.decode(allFrentesRequest.body);
        List<Frente> frentes = List<Frente>.from(l.map((model)=> Frente.fromJson(model)));
        return frentes;
      }

      Future<List<Frente>> getAllFrenteListByEntradaFinanceira(int entradaFinanceiraId) async {
        final allFrentesRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&entradaFinanceiraId.in=$entradaFinanceiraId&sort=id,asc');
        Iterable l = json.decode(allFrentesRequest.body);
        List<Frente> frentes = List<Frente>.from(l.map((model)=> Frente.fromJson(model)));
        return frentes;
      }

      Future<List<Frente>> getAllFrenteListBySaidaFinanceira(int saidaFinanceiraId) async {
        final allFrentesRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&saidaFinanceiraId.in=$saidaFinanceiraId&sort=id,asc');
        Iterable l = json.decode(allFrentesRequest.body);
        List<Frente> frentes = List<Frente>.from(l.map((model)=> Frente.fromJson(model)));
        return frentes;
      }

  Future<Frente> getFrente(int? id) async {
    final frenteRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return Frente.fromJson(json.decode(frenteRequest.body));
  }

  Future<Frente> create(Frente frente) async {
    final frenteRequest = await HttpUtils.postRequest('$uriEndpoint', frente.toString());
    return Frente.fromJson(json.decode(frenteRequest.body));
  }

  Future<Frente> update(Frente frente) async {
    final frenteRequest = await HttpUtils.putRequest('$uriEndpoint', frente.toString(), frente.id!);
    return Frente.fromJson(json.decode(frenteRequest.body));
  }

  Future<void> delete(int id) async {
    final frenteRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
