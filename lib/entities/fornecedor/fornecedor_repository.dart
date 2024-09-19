import 'dart:convert';
import 'package:cocoverde/entities/fornecedor/fornecedor_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class FornecedorRepository {
    FornecedorRepository();

  static final String uriEndpoint = '/fornecedors';

  Future<List<Fornecedor>> getAllFornecedors() async {
    final allFornecedorsRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allFornecedorsRequest.body);
    List<Fornecedor> fornecedors = List<Fornecedor>.from(l.map((model)=> Fornecedor.fromJson(model)));
    return fornecedors;
  }


      Future<List<Fornecedor>> getAllFornecedorListByProduto(int produtoId) async {
        final allFornecedorsRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&produtoId.in=$produtoId&sort=id,asc');
        Iterable l = json.decode(allFornecedorsRequest.body);
        List<Fornecedor> fornecedors = List<Fornecedor>.from(l.map((model)=> Fornecedor.fromJson(model)));
        return fornecedors;
      }

      Future<List<Fornecedor>> getAllFornecedorListByEndereco(int enderecoId) async {
        final allFornecedorsRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&enderecoId.in=$enderecoId&sort=id,asc');
        Iterable l = json.decode(allFornecedorsRequest.body);
        List<Fornecedor> fornecedors = List<Fornecedor>.from(l.map((model)=> Fornecedor.fromJson(model)));
        return fornecedors;
      }

      Future<List<Fornecedor>> getAllFornecedorListByEntradaFinanceira(int entradaFinanceiraId) async {
        final allFornecedorsRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&entradaFinanceiraId.in=$entradaFinanceiraId&sort=id,asc');
        Iterable l = json.decode(allFornecedorsRequest.body);
        List<Fornecedor> fornecedors = List<Fornecedor>.from(l.map((model)=> Fornecedor.fromJson(model)));
        return fornecedors;
      }

  Future<Fornecedor> getFornecedor(int? id) async {
    final fornecedorRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return Fornecedor.fromJson(json.decode(fornecedorRequest.body));
  }

  Future<Fornecedor> create(Fornecedor fornecedor) async {
    final fornecedorRequest = await HttpUtils.postRequest('$uriEndpoint', fornecedor.toString());
    return Fornecedor.fromJson(json.decode(fornecedorRequest.body));
  }

  Future<Fornecedor> update(Fornecedor fornecedor) async {
    final fornecedorRequest = await HttpUtils.putRequest('$uriEndpoint', fornecedor.toString(), fornecedor.id!);
    return Fornecedor.fromJson(json.decode(fornecedorRequest.body));
  }

  Future<void> delete(int id) async {
    final fornecedorRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
