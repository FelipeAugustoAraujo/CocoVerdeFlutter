import 'dart:convert';
import 'package:cocoverde/entities/estoque/estoque_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class EstoqueRepository {
    EstoqueRepository();

  static final String uriEndpoint = '/estoques';

  Future<List<Estoque>> getAllEstoques() async {
    final allEstoquesRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allEstoquesRequest.body);
    List<Estoque> estoques = List<Estoque>.from(l.map((model)=> Estoque.fromJson(model)));
    return estoques;
  }


      Future<List<Estoque>> getAllEstoqueListByProduto(int produtoId) async {
        final allEstoquesRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&produtoId.in=$produtoId&sort=id,asc');
        Iterable l = json.decode(allEstoquesRequest.body);
        List<Estoque> estoques = List<Estoque>.from(l.map((model)=> Estoque.fromJson(model)));
        return estoques;
      }

      Future<List<Estoque>> getAllEstoqueListByEntradaFinanceira(int entradaFinanceiraId) async {
        final allEstoquesRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&entradaFinanceiraId.in=$entradaFinanceiraId&sort=id,asc');
        Iterable l = json.decode(allEstoquesRequest.body);
        List<Estoque> estoques = List<Estoque>.from(l.map((model)=> Estoque.fromJson(model)));
        return estoques;
      }

      Future<List<Estoque>> getAllEstoqueListBySaidaFinanceira(int saidaFinanceiraId) async {
        final allEstoquesRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&saidaFinanceiraId.in=$saidaFinanceiraId&sort=id,asc');
        Iterable l = json.decode(allEstoquesRequest.body);
        List<Estoque> estoques = List<Estoque>.from(l.map((model)=> Estoque.fromJson(model)));
        return estoques;
      }

  Future<Estoque> getEstoque(int? id) async {
    final estoqueRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return Estoque.fromJson(json.decode(estoqueRequest.body));
  }

  Future<Estoque> create(Estoque estoque) async {
    final estoqueRequest = await HttpUtils.postRequest('$uriEndpoint', estoque.toString());
    return Estoque.fromJson(json.decode(estoqueRequest.body));
  }

  Future<Estoque> update(Estoque estoque) async {
    final estoqueRequest = await HttpUtils.putRequest('$uriEndpoint', estoque.toString(), estoque.id!);
    return Estoque.fromJson(json.decode(estoqueRequest.body));
  }

  Future<void> delete(int id) async {
    final estoqueRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
