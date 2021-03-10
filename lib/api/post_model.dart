import 'package:flutter/cupertino.dart';

//Live Data Indonesia
class Covid {
  final String name;
  final String jumlah_positif;
  final String jumlah_sembuh;
  final String jumlah_meninggal;

  Covid({
    @required this.name,
    @required this.jumlah_positif,
    @required this.jumlah_sembuh,
    @required this.jumlah_meninggal,
  });

  factory Covid.fromJson(Map<String, dynamic> json) {
    return Covid(
      name: json['name'] as String,
      jumlah_positif: json['jumlah_positif'] as String,
      jumlah_sembuh: json['jumlah_sembuh'] as String,
      jumlah_meninggal: json['jumlah_meninggal'] as String,
    );
  }
}

// Live Data Global
class Post {
  final String name;
  final String value;

  Post({
    @required this.name,
    @required this.value,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'] as String,
      value: json['value'] as String,
    );
  }
}

// Provinsi
class CovidProvinsi {
  final String provinsi;
  final int jumlah_positif;
  final int jumlah_sembuh;
  final int jumlah_meninggal;

  CovidProvinsi({
    @required this.provinsi,
    @required this.jumlah_positif,
    @required this.jumlah_sembuh,
    @required this.jumlah_meninggal,
  });

  factory CovidProvinsi.fromJson(Map<String, dynamic> json) {
    return CovidProvinsi(
      provinsi: json['provinsi'] as String,
      jumlah_positif: json['jumlah_positif'] as int,
      jumlah_sembuh: json['jumlah_sembuh'] as int,
      jumlah_meninggal: json['jumlah_meninggal'] as int,
    );
  }
}

// Global
class CovidGlobal {
  final String countryRegion;
  final int confirmed;
  final int deaths;
  final int recovered;
  final int active;

  CovidGlobal({
    @required this.countryRegion,
    @required this.confirmed,
    @required this.deaths,
    @required this.recovered,
    @required this.active,
  });

  factory CovidGlobal.fromJson(Map<String, dynamic> json) {
    return CovidGlobal(
      countryRegion: json['attributes']['Country_Region'] as String,
      confirmed: json['attributes']['Confirmed'] as int,
      deaths: json['attributes']['Deaths'] as int,
      recovered: json['attributes']['Recovered'] as int,
      active: json['attributes']['Active'] as int,
    );
  }
}
