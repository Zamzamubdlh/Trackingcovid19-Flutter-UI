import 'package:covid19/constant.dart';
import 'package:covid19/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:format_indonesia/format_indonesia.dart';

import 'api/http_service.dart';
import 'api/post_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            body1: TextStyle(color: kBodyTextColor),
          )),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final DataIndonesia _getIndonesia = new DataIndonesia();
    final GetPositif _getPost = new GetPositif();
    final DataIndo _getIndo = new DataIndo();
    final DataGlobal _getGlobal = new DataGlobal();
    var waktu = Waktu();

    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/family.svg",
              textTop: "Tracking",
              textBottom: "Covid-19",
              offset: offset,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                      future: _getIndonesia.getDataIndonesia(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Covid>> snapshot) {
                        if (snapshot.hasData) {
                          List<Covid> dataIndonesia = snapshot.data;
                          return Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Terakhir Update : ",
                                          style: kTitleTextstyle,
                                        ),
                                        TextSpan(
                                          text: (waktu.yMMMMEEEEd()),
                                          style: TextStyle(
                                            color: kTextLightColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Card(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  color: Colors.red[800],
                                  child: ListTile(
                                    title: Text(
                                      "Positif",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      dataIndonesia[0]
                                              .jumlah_positif
                                              .toString() +
                                          " Orang",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/icons/positif.png'),
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  color: Colors.green[800],
                                  child: ListTile(
                                    title: Text(
                                      "Sembuh",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      dataIndonesia[0]
                                              .jumlah_sembuh
                                              .toString() +
                                          " Orang",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/icons/sembuh.png'),
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  color: Colors.purple[900],
                                  child: ListTile(
                                    title: Text(
                                      "Meninggal",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      dataIndonesia[0]
                                              .jumlah_meninggal
                                              .toString() +
                                          " Orang",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/icons/meninggal.png'),
                                    ),
                                  ),
                                ),
                              ),
                              FutureBuilder(
                                  future: _getPost.getPost(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Post>> snapshot) {
                                    if (snapshot.hasData) {
                                      List<Post> posts = snapshot.data;
                                      return Column(
                                        children: <Widget>[
                                          Card(
                                            child: Container(
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(10),
                                              color: Colors.cyan[900],
                                              child: ListTile(
                                                title: Text(
                                                  "Total Positif di Dunia",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                subtitle: Text(
                                                  posts[0].value.toString() +
                                                      " Orang",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                leading: CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      'assets/icons/global_master.png'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                              SizedBox(height: 20),
                              Row(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Coronavirus Local",
                                          style: kTitleTextstyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: FutureBuilder(
                                  future: _getIndo.getDataIndo(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<CovidProvinsi>>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      List<CovidProvinsi> dataIndo =
                                          snapshot.data;
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          columns: [
                                            DataColumn(label: Text('Provinsi')),
                                            DataColumn(label: Text('Positif')),
                                            DataColumn(label: Text('Sembuh')),
                                            DataColumn(
                                                label: Text('Meninggal')),
                                          ],
                                          rows: dataIndo
                                              .map((CovidProvinsi dataIndo) =>
                                                  DataRow(cells: [
                                                    DataCell(Text(
                                                        dataIndo.provinsi)),
                                                    DataCell(Text(dataIndo
                                                        .jumlah_positif
                                                        .toString())),
                                                    DataCell(Text(dataIndo
                                                        .jumlah_sembuh
                                                        .toString())),
                                                    DataCell(Text(dataIndo
                                                        .jumlah_meninggal
                                                        .toString())),
                                                  ]))
                                              .toList(),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Coronavirus Global",
                                          style: kTitleTextstyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: FutureBuilder(
                                  future: _getGlobal.getDataGlobal(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<CovidGlobal>>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      List<CovidGlobal> dataGLobal =
                                          snapshot.data;
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Center(
                                          child: DataTable(
                                            sortColumnIndex: 0,
                                            sortAscending: true,
                                            columns: [
                                              DataColumn(
                                                label: Text(
                                                  'Negara',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                  label: Text('Positif',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                      ))),
                                              DataColumn(
                                                  label: Text('Sembuh',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                      ))),
                                              DataColumn(
                                                  label: Text('Meninggal',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                      ))),
                                            ],
                                            rows: dataGLobal
                                                .map((CovidGlobal dataGlobal) =>
                                                    DataRow(cells: [
                                                      DataCell(Text(dataGlobal
                                                          .countryRegion)),
                                                      DataCell(Text(dataGlobal
                                                          .confirmed
                                                          .toString())),
                                                      DataCell(Text(dataGlobal
                                                          .recovered
                                                          .toString())),
                                                      DataCell(Text(dataGlobal
                                                          .deaths
                                                          .toString())),
                                                    ]))
                                                .toList(),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Peta Sebaran Covid-19",
                                    style: kTitleTextstyle,
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: SizedBox(
                                  height: 200.0,
                                  width: 350.0,
                                  child: Carousel(
                                    images: [
                                      Container(
                                        constraints: new BoxConstraints.expand(
                                          height: 200.0,
                                        ),
                                        padding: new EdgeInsets.only(
                                            left: 16.0,
                                            bottom: 8.0,
                                            right: 16.0),
                                        decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/images/indo.png'),
                                          ),
                                        ),
                                        child: new Stack(
                                          children: <Widget>[
                                            new Positioned(
                                              left: 0.0,
                                              bottom: 0.0,
                                              child: new Text('Indonesia',
                                                  style: new TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.0,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        constraints: new BoxConstraints.expand(
                                          height: 200.0,
                                        ),
                                        padding: new EdgeInsets.only(
                                            left: 16.0,
                                            bottom: 8.0,
                                            right: 16.0),
                                        decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            image: new AssetImage(
                                                'assets/images/map_dunia.png'),
                                          ),
                                        ),
                                        child: new Stack(
                                          children: <Widget>[
                                            new Positioned(
                                              left: 0.0,
                                              bottom: 0.0,
                                              child: new Text(
                                                'Dunia',
                                                style: new TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    dotPosition: DotPosition.bottomRight,
                                    autoplay: true,
                                    dotSize: 4.0,
                                    dotSpacing: 15.0,
                                    dotColor: Colors.black,
                                    indicatorBgPadding: 5.0,
                                    dotBgColor: Colors.grey.withOpacity(0.8),
                                    // borderRadius: true,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
