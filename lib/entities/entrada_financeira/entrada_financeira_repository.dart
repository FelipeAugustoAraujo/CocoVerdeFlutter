import 'dart:convert';
import 'package:cocoverde/entities/entrada_financeira/entrada_financeira_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class EntradaFinanceiraRepository {
    EntradaFinanceiraRepository();

  static final String uriEndpoint = '/entrada-financeiras';

  Future<List<EntradaFinanceira>> getAllEntradaFinanceiras() async {
    final allEntradaFinanceirasRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allEntradaFinanceirasRequest.body);
    List<EntradaFinanceira> entradaFinanceiras = List<EntradaFinanceira>.from(l.map((model)=> EntradaFinanceira.fromJson(model)));
    return entradaFinanceiras;
  }


      Future<List<EntradaFinanceira>> getAllEntradaFinanceiraListByFornecedor(int fornecedorId) async {
        final allEntradaFinanceirasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&fornecedorId.in=$fornecedorId&sort=id,asc');
        Iterable l = json.decode(allEntradaFinanceirasRequest.body);
        List<EntradaFinanceira> entradaFinanceiras = List<EntradaFinanceira>.from(l.map((model)=> EntradaFinanceira.fromJson(model)));
        return entradaFinanceiras;
      }

      Future<List<EntradaFinanceira>> getAllEntradaFinanceiraListByEstoque(int estoqueId) async {
        final allEntradaFinanceirasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&estoqueId.in=$estoqueId&sort=id,asc');
        Iterable l = json.decode(allEntradaFinanceirasRequest.body);
        List<EntradaFinanceira> entradaFinanceiras = List<EntradaFinanceira>.from(l.map((model)=> EntradaFinanceira.fromJson(model)));
        return entradaFinanceiras;
      }

      Future<List<EntradaFinanceira>> getAllEntradaFinanceiraListByFrente(int frenteId) async {
        final allEntradaFinanceirasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&frenteId.in=$frenteId&sort=id,asc');
        Iterable l = json.decode(allEntradaFinanceirasRequest.body);
        List<EntradaFinanceira> entradaFinanceiras = List<EntradaFinanceira>.from(l.map((model)=> EntradaFinanceira.fromJson(model)));
        return entradaFinanceiras;
      }

      Future<List<EntradaFinanceira>> getAllEntradaFinanceiraListByFechamentoCaixaDetalhes(int fechamentoCaixaDetalhesId) async {
        final allEntradaFinanceirasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&fechamentoCaixaDetalhesId.in=$fechamentoCaixaDetalhesId&sort=id,asc');
        Iterable l = json.decode(allEntradaFinanceirasRequest.body);
        List<EntradaFinanceira> entradaFinanceiras = List<EntradaFinanceira>.from(l.map((model)=> EntradaFinanceira.fromJson(model)));
        return entradaFinanceiras;
      }

      Future<List<EntradaFinanceira>> getAllEntradaFinanceiraListByDetalhesEntradaFinanceira(int detalhesEntradaFinanceiraId) async {
        final allEntradaFinanceirasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&detalhesEntradaFinanceiraId.in=$detalhesEntradaFinanceiraId&sort=id,asc');
        Iterable l = json.decode(allEntradaFinanceirasRequest.body);
        List<EntradaFinanceira> entradaFinanceiras = List<EntradaFinanceira>.from(l.map((model)=> EntradaFinanceira.fromJson(model)));
        return entradaFinanceiras;
      }

      Future<List<EntradaFinanceira>> getAllEntradaFinanceiraListByImagem(int imagemId) async {
        final allEntradaFinanceirasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&imagemId.in=$imagemId&sort=id,asc');
        Iterable l = json.decode(allEntradaFinanceirasRequest.body);
        List<EntradaFinanceira> entradaFinanceiras = List<EntradaFinanceira>.from(l.map((model)=> EntradaFinanceira.fromJson(model)));
        return entradaFinanceiras;
      }

  Future<EntradaFinanceira> getEntradaFinanceira(int? id) async {
    final entradaFinanceiraRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return EntradaFinanceira.fromJson(json.decode(entradaFinanceiraRequest.body));
  }

  Future<EntradaFinanceira> create(EntradaFinanceira entradaFinanceira) async {
    final entradaFinanceiraRequest = await HttpUtils.postRequest('$uriEndpoint', entradaFinanceira.toString());
    return EntradaFinanceira.fromJson(json.decode(entradaFinanceiraRequest.body));
  }

  Future<EntradaFinanceira> update(EntradaFinanceira entradaFinanceira) async {
    final entradaFinanceiraRequest = await HttpUtils.putRequest('$uriEndpoint', entradaFinanceira.toString(), entradaFinanceira.id!);
    return EntradaFinanceira.fromJson(json.decode(entradaFinanceiraRequest.body));
  }

  Future<void> delete(int id) async {
    final entradaFinanceiraRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
