import 'dart:convert';
import 'package:cocoverde/entities/imagem/imagem_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

class ImagemRepository {
    ImagemRepository();

  static final String uriEndpoint = '/imagems';

  Future<List<Imagem>> getAllImagems() async {
    final allImagemsRequest = await HttpUtils.getRequest(uriEndpoint);
    Iterable l = json.decode(allImagemsRequest.body);
    List<Imagem> imagems = List<Imagem>.from(l.map((model)=> Imagem.fromJson(model)));
    return imagems;
  }


      Future<List<Imagem>> getAllImagemListBySaidaFinanceira(int saidaFinanceiraId) async {
        final allImagemsRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&saidaFinanceiraId.in=$saidaFinanceiraId&sort=id,asc');
        Iterable l = json.decode(allImagemsRequest.body);
        List<Imagem> imagems = List<Imagem>.from(l.map((model)=> Imagem.fromJson(model)));
        return imagems;
      }

      Future<List<Imagem>> getAllImagemListByEntradaFinanceira(int entradaFinanceiraId) async {
        final allImagemsRequest = await HttpUtils.getRequest('$uriEndpoint?eagerload=true&entradaFinanceiraId.in=$entradaFinanceiraId&sort=id,asc');
        Iterable l = json.decode(allImagemsRequest.body);
        List<Imagem> imagems = List<Imagem>.from(l.map((model)=> Imagem.fromJson(model)));
        return imagems;
      }

  Future<Imagem> getImagem(int? id) async {
    final imagemRequest = await HttpUtils.getRequest('$uriEndpoint/$id');
    return Imagem.fromJson(json.decode(imagemRequest.body));
  }

  Future<Imagem> create(Imagem imagem) async {
    final imagemRequest = await HttpUtils.postRequest('$uriEndpoint', imagem.toString());
    return Imagem.fromJson(json.decode(imagemRequest.body));
  }

  Future<Imagem> update(Imagem imagem) async {
    final imagemRequest = await HttpUtils.putRequest('$uriEndpoint', imagem.toString(), imagem.id!);
    return Imagem.fromJson(json.decode(imagemRequest.body));
  }

  Future<void> delete(int id) async {
    final imagemRequest = await HttpUtils.deleteRequest('$uriEndpoint/$id');
  }
}
