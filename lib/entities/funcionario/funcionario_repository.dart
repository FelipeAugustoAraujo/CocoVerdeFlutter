import 'dart:convert';
import 'package:Cocoverde/entities/funcionario/funcionario_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';

class FuncionarioRepository {
    FuncionarioRepository();

  static final String uriEndpoint = '/funcionarios';

  Future<List<Funcionario>> getAllFuncionarios() async {
    final allFuncionariosRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allFuncionariosRequest.body);
    List<Funcionario> funcionarios = List<Funcionario>.from(l.map((model)=> Funcionario.fromJson(model)));
    return funcionarios;
  }


      Future<List<Funcionario>> getAllFuncionarioListByEndereco(int enderecoId) async {
        final allFuncionariosRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&enderecoId.in=$enderecoId&sort=id,asc');
        Iterable l = json.decode(allFuncionariosRequest.body);
        List<Funcionario> funcionarios = List<Funcionario>.from(l.map((model)=> Funcionario.fromJson(model)));
        return funcionarios;
      }

  Future<Funcionario> getFuncionario(int? id) async {
    final funcionarioRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return Funcionario.fromJson(json.decode(funcionarioRequest.body));
  }

  Future<Funcionario> create(Funcionario funcionario) async {
    final funcionarioRequest = await HttpUtils.postRequest('$uriEndpoint', funcionario.toString());
    return Funcionario.fromJson(json.decode(funcionarioRequest.body));
  }

  Future<Funcionario> update(Funcionario funcionario) async {
    final funcionarioRequest = await HttpUtils.putRequest('$uriEndpoint', funcionario.toString(), funcionario.id!);
    return Funcionario.fromJson(json.decode(funcionarioRequest.body));
  }

  Future<void> delete(int id) async {
    final funcionarioRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
