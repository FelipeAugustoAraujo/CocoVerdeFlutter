import 'dart:convert';
import 'package:cocoverde/entities/endereco/endereco_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class EnderecoRepository {
    EnderecoRepository();

  static final String uriEndpoint = '/enderecos';

  Future<List<Endereco>> getAllEnderecos() async {
    final allEnderecosRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allEnderecosRequest.body);
    List<Endereco> enderecos = List<Endereco>.from(l.map((model)=> Endereco.fromJson(model)));
    return enderecos;
  }


      Future<List<Endereco>> getAllEnderecoListByFornecedor(int fornecedorId) async {
        final allEnderecosRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&fornecedorId.in=$fornecedorId&sort=id,asc');
        Iterable l = json.decode(allEnderecosRequest.body);
        List<Endereco> enderecos = List<Endereco>.from(l.map((model)=> Endereco.fromJson(model)));
        return enderecos;
      }

      Future<List<Endereco>> getAllEnderecoListByFuncionario(int funcionarioId) async {
        final allEnderecosRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&funcionarioId.in=$funcionarioId&sort=id,asc');
        Iterable l = json.decode(allEnderecosRequest.body);
        List<Endereco> enderecos = List<Endereco>.from(l.map((model)=> Endereco.fromJson(model)));
        return enderecos;
      }

      Future<List<Endereco>> getAllEnderecoListByCliente(int clienteId) async {
        final allEnderecosRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&clienteId.in=$clienteId&sort=id,asc');
        Iterable l = json.decode(allEnderecosRequest.body);
        List<Endereco> enderecos = List<Endereco>.from(l.map((model)=> Endereco.fromJson(model)));
        return enderecos;
      }

      Future<List<Endereco>> getAllEnderecoListByCidade(int cidadeId) async {
        final allEnderecosRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&cidadeId.in=$cidadeId&sort=id,asc');
        Iterable l = json.decode(allEnderecosRequest.body);
        List<Endereco> enderecos = List<Endereco>.from(l.map((model)=> Endereco.fromJson(model)));
        return enderecos;
      }

  Future<Endereco> getEndereco(int? id) async {
    final enderecoRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return Endereco.fromJson(json.decode(enderecoRequest.body));
  }

  Future<Endereco> create(Endereco endereco) async {
    final enderecoRequest = await HttpUtils.postRequest('$uriEndpoint', endereco.toString());
    return Endereco.fromJson(json.decode(enderecoRequest.body));
  }

  Future<Endereco> update(Endereco endereco) async {
    final enderecoRequest = await HttpUtils.putRequest('$uriEndpoint', endereco.toString(), endereco.id!);
    return Endereco.fromJson(json.decode(enderecoRequest.body));
  }

  Future<void> delete(int id) async {
    final enderecoRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
