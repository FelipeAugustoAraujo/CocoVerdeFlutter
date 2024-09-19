import 'dart:convert';
import 'package:cocoverde/entities/detalhes_saida_financeira/detalhes_saida_financeira_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class DetalhesSaidaFinanceiraRepository {
    DetalhesSaidaFinanceiraRepository();

  static final String uriEndpoint = '/detalhes-saida-financeiras';

  Future<List<DetalhesSaidaFinanceira>> getAllDetalhesSaidaFinanceiras() async {
    final allDetalhesSaidaFinanceirasRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allDetalhesSaidaFinanceirasRequest.body);
    List<DetalhesSaidaFinanceira> detalhesSaidaFinanceiras = List<DetalhesSaidaFinanceira>.from(l.map((model)=> DetalhesSaidaFinanceira.fromJson(model)));
    return detalhesSaidaFinanceiras;
  }


  Future<DetalhesSaidaFinanceira> getDetalhesSaidaFinanceira(int? id) async {
    final detalhesSaidaFinanceiraRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return DetalhesSaidaFinanceira.fromJson(json.decode(detalhesSaidaFinanceiraRequest.body));
  }

  Future<DetalhesSaidaFinanceira> create(DetalhesSaidaFinanceira detalhesSaidaFinanceira) async {
    final detalhesSaidaFinanceiraRequest = await HttpUtils.postRequest('$uriEndpoint', detalhesSaidaFinanceira.toString());
    return DetalhesSaidaFinanceira.fromJson(json.decode(detalhesSaidaFinanceiraRequest.body));
  }

  Future<DetalhesSaidaFinanceira> update(DetalhesSaidaFinanceira detalhesSaidaFinanceira) async {
    final detalhesSaidaFinanceiraRequest = await HttpUtils.putRequest('$uriEndpoint', detalhesSaidaFinanceira.toString(), detalhesSaidaFinanceira.id!);
    return DetalhesSaidaFinanceira.fromJson(json.decode(detalhesSaidaFinanceiraRequest.body));
  }

  Future<void> delete(int id) async {
    final detalhesSaidaFinanceiraRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
