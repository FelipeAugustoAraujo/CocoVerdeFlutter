import 'dart:convert';
import 'package:Cocoverde/entities/cliente/cliente_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';

class ClienteRepository {
    ClienteRepository();

  static final String uriEndpoint = '/clientes';

  Future<List<Cliente>> getAllClientes() async {
    final allClientesRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allClientesRequest.body);
    List<Cliente> clientes = List<Cliente>.from(l.map((model)=> Cliente.fromJson(model)));
    return clientes;
  }


      Future<List<Cliente>> getAllClienteListByEndereco(int enderecoId) async {
        final allClientesRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&enderecoId.in=$enderecoId&sort=id,asc');
        Iterable l = json.decode(allClientesRequest.body);
        List<Cliente> clientes = List<Cliente>.from(l.map((model)=> Cliente.fromJson(model)));
        return clientes;
      }

  Future<Cliente> getCliente(int? id) async {
    final clienteRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return Cliente.fromJson(json.decode(clienteRequest.body));
  }

  Future<Cliente> create(Cliente cliente) async {
    final clienteRequest = await HttpUtils.postRequest('$uriEndpoint', cliente.toString());
    return Cliente.fromJson(json.decode(clienteRequest.body));
  }

  Future<Cliente> update(Cliente cliente) async {
    final clienteRequest = await HttpUtils.putRequest('$uriEndpoint', cliente.toString(), cliente.id!);
    return Cliente.fromJson(json.decode(clienteRequest.body));
  }

  Future<void> delete(int id) async {
    final clienteRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
