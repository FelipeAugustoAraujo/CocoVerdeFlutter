import 'dart:convert';
import 'package:cocoverde/entities/configuracao/configuracao_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class ConfiguracaoRepository {
    ConfiguracaoRepository();

  static final String uriEndpoint = '/configuracaos';

  Future<List<Configuracao>> getAllConfiguracaos() async {
    final allConfiguracaosRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allConfiguracaosRequest.body);
    List<Configuracao> configuracaos = List<Configuracao>.from(l.map((model)=> Configuracao.fromJson(model)));
    return configuracaos;
  }


  Future<Configuracao> getConfiguracao(int? id) async {
    final configuracaoRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return Configuracao.fromJson(json.decode(configuracaoRequest.body));
  }

  Future<Configuracao> create(Configuracao configuracao) async {
    final configuracaoRequest = await HttpUtils.postRequest('$uriEndpoint', configuracao.toString());
    return Configuracao.fromJson(json.decode(configuracaoRequest.body));
  }

  Future<Configuracao> update(Configuracao configuracao) async {
    final configuracaoRequest = await HttpUtils.putRequest('$uriEndpoint', configuracao.toString(), configuracao.id!);
    return Configuracao.fromJson(json.decode(configuracaoRequest.body));
  }

  Future<void> delete(int id) async {
    final configuracaoRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
