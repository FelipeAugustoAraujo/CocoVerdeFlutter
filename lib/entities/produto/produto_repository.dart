import 'dart:convert';
import 'package:Cocoverde/entities/produto/produto_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';

class ProdutoRepository {
    ProdutoRepository();

  static final String uriEndpoint = '/produtos';

  Future<List<Produto>> getAllProdutos() async {
    final allProdutosRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allProdutosRequest.body);
    List<Produto> produtos = List<Produto>.from(l.map((model)=> Produto.fromJson(model)));
    return produtos;
  }


      Future<List<Produto>> getAllProdutoListByEstoque(int estoqueId) async {
        final allProdutosRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&estoqueId.in=$estoqueId&sort=id,asc');
        Iterable l = json.decode(allProdutosRequest.body);
        List<Produto> produtos = List<Produto>.from(l.map((model)=> Produto.fromJson(model)));
        return produtos;
      }

      Future<List<Produto>> getAllProdutoListByFrente(int frenteId) async {
        final allProdutosRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&frenteId.in=$frenteId&sort=id,asc');
        Iterable l = json.decode(allProdutosRequest.body);
        List<Produto> produtos = List<Produto>.from(l.map((model)=> Produto.fromJson(model)));
        return produtos;
      }

      Future<List<Produto>> getAllProdutoListByDetalhesEntradaFinanceira(int detalhesEntradaFinanceiraId) async {
        final allProdutosRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&detalhesEntradaFinanceiraId.in=$detalhesEntradaFinanceiraId&sort=id,asc');
        Iterable l = json.decode(allProdutosRequest.body);
        List<Produto> produtos = List<Produto>.from(l.map((model)=> Produto.fromJson(model)));
        return produtos;
      }

      Future<List<Produto>> getAllProdutoListByFornecedor(int fornecedorId) async {
        final allProdutosRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&fornecedorId.in=$fornecedorId&sort=id,asc');
        Iterable l = json.decode(allProdutosRequest.body);
        List<Produto> produtos = List<Produto>.from(l.map((model)=> Produto.fromJson(model)));
        return produtos;
      }

  Future<Produto> getProduto(int? id) async {
    final produtoRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return Produto.fromJson(json.decode(produtoRequest.body));
  }

  Future<Produto> create(Produto produto) async {
    final produtoRequest = await HttpUtils.postRequest('$uriEndpoint', produto.toString());
    return Produto.fromJson(json.decode(produtoRequest.body));
  }

  Future<Produto> update(Produto produto) async {
    final produtoRequest = await HttpUtils.putRequest('$uriEndpoint', produto.toString(), produto.id!);
    return Produto.fromJson(json.decode(produtoRequest.body));
  }

  Future<void> delete(int id) async {
    final produtoRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
