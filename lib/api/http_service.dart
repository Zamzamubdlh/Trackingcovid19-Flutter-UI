import 'dart:convert';
import 'package:covid19/api/post_model.dart';
import 'package:http/http.dart';

// Live Data Indonesia
class DataIndonesia {
  final String url = "http://apptrackingcovid19.herokuapp.com/api/indonesia";
  Future<List<Covid>> getDataIndonesia() async {
    Response res = await get(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['data'];
      List<Covid> dataIndonesia =
          body.map((dynamic item) => Covid.fromJson(item)).toList();
      return dataIndonesia;
    } else {
      throw "tidak bisa mendapat data";
    }
  }
}

// Live Data Global
class GetPositif {
  final String url = "http://apptrackingcovid19.herokuapp.com/api/positif";
  Future<List<Post>> getPost() async {
    Response res = await get(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['data'];
      List<Post> posts =
          body.map((dynamic item) => Post.fromJson(item)).toList();
      return posts;
    } else {
      throw "tidak bisa mendapat data";
    }
  }
}

// Provinsi
class DataIndo {
  final String url = "http://apptrackingcovid19.herokuapp.com/api/provinsiapi";
  Future<List<CovidProvinsi>> getDataIndo() async {
    Response res = await get(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['data'];
      List<CovidProvinsi> dataIndo =
          body.map((dynamic item) => CovidProvinsi.fromJson(item)).toList();
      return dataIndo;
    } else {
      throw "tidak bisa mendapat data";
    }
  }
}

// Global
class DataGlobal {
  final String url = "https://api.kawalcorona.com/";
  Future<List<CovidGlobal>> getDataGlobal() async {
    Response res = await get(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<CovidGlobal> dataGlobal =
          body.map((dynamic item) => CovidGlobal.fromJson(item)).toList();
      return dataGlobal;
    } else {
      throw "tidak bisa mendapat data";
    }
  }
}
