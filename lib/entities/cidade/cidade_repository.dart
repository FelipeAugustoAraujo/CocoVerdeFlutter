import 'dart:convert';
import 'package:cocoverde/entities/cidade/cidade_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class CidadeRepository {
    CidadeRepository();

  static final String uriEndpoint = '/cidades';

  Future<List<Cidade>> getAllCidades() async {
    final allCidadesRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allCidadesRequest.body);
    List<Cidade> cidades = List<Cidade>.from(l.map((model)=> Cidade.fromJson(model)));
    return cidades;
  }


      Future<List<Cidade>> getAllCidadeListByEndereco(int enderecoId) async {
        final allCidadesRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&enderecoId.in=$enderecoId&sort=id,asc');
        Iterable l = json.decode(allCidadesRequest.body);
        List<Cidade> cidades = List<Cidade>.from(l.map((model)=> Cidade.fromJson(model)));
        return cidades;
      }

  Future<Cidade> getCidade(int? id) async {
    final cidadeRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return Cidade.fromJson(json.decode(cidadeRequest.body));
  }

  Future<Cidade> create(Cidade cidade) async {
    final cidadeRequest = await HttpUtils.postRequest('$uriEndpoint', cidade.toString());
    return Cidade.fromJson(json.decode(cidadeRequest.body));
  }

  Future<Cidade> update(Cidade cidade) async {
    final cidadeRequest = await HttpUtils.putRequest('$uriEndpoint', cidade.toString(), cidade.id!);
    return Cidade.fromJson(json.decode(cidadeRequest.body));
  }

  Future<void> delete(int id) async {
    final cidadeRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
