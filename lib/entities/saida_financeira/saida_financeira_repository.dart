import 'dart:convert';
import 'package:cocoverde/entities/saida_financeira/saida_financeira_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class SaidaFinanceiraRepository {
    SaidaFinanceiraRepository();

  static final String uriEndpoint = '/saida-financeiras';

  Future<List<SaidaFinanceira>> getAllSaidaFinanceiras() async {
    final allSaidaFinanceirasRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allSaidaFinanceirasRequest.body);
    List<SaidaFinanceira> saidaFinanceiras = List<SaidaFinanceira>.from(l.map((model)=> SaidaFinanceira.fromJson(model)));
    return saidaFinanceiras;
  }


      Future<List<SaidaFinanceira>> getAllSaidaFinanceiraListByEstoque(int estoqueId) async {
        final allSaidaFinanceirasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&estoqueId.in=$estoqueId&sort=id,asc');
        Iterable l = json.decode(allSaidaFinanceirasRequest.body);
        List<SaidaFinanceira> saidaFinanceiras = List<SaidaFinanceira>.from(l.map((model)=> SaidaFinanceira.fromJson(model)));
        return saidaFinanceiras;
      }

      Future<List<SaidaFinanceira>> getAllSaidaFinanceiraListByFrente(int frenteId) async {
        final allSaidaFinanceirasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&frenteId.in=$frenteId&sort=id,asc');
        Iterable l = json.decode(allSaidaFinanceirasRequest.body);
        List<SaidaFinanceira> saidaFinanceiras = List<SaidaFinanceira>.from(l.map((model)=> SaidaFinanceira.fromJson(model)));
        return saidaFinanceiras;
      }

      Future<List<SaidaFinanceira>> getAllSaidaFinanceiraListByFechamentoCaixaDetalhes(int fechamentoCaixaDetalhesId) async {
        final allSaidaFinanceirasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&fechamentoCaixaDetalhesId.in=$fechamentoCaixaDetalhesId&sort=id,asc');
        Iterable l = json.decode(allSaidaFinanceirasRequest.body);
        List<SaidaFinanceira> saidaFinanceiras = List<SaidaFinanceira>.from(l.map((model)=> SaidaFinanceira.fromJson(model)));
        return saidaFinanceiras;
      }

      Future<List<SaidaFinanceira>> getAllSaidaFinanceiraListByImagem(int imagemId) async {
        final allSaidaFinanceirasRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&imagemId.in=$imagemId&sort=id,asc');
        Iterable l = json.decode(allSaidaFinanceirasRequest.body);
        List<SaidaFinanceira> saidaFinanceiras = List<SaidaFinanceira>.from(l.map((model)=> SaidaFinanceira.fromJson(model)));
        return saidaFinanceiras;
      }

  Future<SaidaFinanceira> getSaidaFinanceira(int? id) async {
    final saidaFinanceiraRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return SaidaFinanceira.fromJson(json.decode(saidaFinanceiraRequest.body));
  }

  Future<SaidaFinanceira> create(SaidaFinanceira saidaFinanceira) async {
    final saidaFinanceiraRequest = await HttpUtils.postRequest('$uriEndpoint', saidaFinanceira.toString());
    return SaidaFinanceira.fromJson(json.decode(saidaFinanceiraRequest.body));
  }

  Future<SaidaFinanceira> update(SaidaFinanceira saidaFinanceira) async {
    final saidaFinanceiraRequest = await HttpUtils.putRequest('$uriEndpoint', saidaFinanceira.toString(), saidaFinanceira.id!);
    return SaidaFinanceira.fromJson(json.decode(saidaFinanceiraRequest.body));
  }

  Future<void> delete(int id) async {
    final saidaFinanceiraRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
