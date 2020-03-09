import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import 'Cukai.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:async_loader/async_loader.dart';

class Search extends StatelessWidget {
  final String text;
  final double fontSize = 15.0;

  Search({Key key, @required this.text}) : super(key: key);

  Future<List<Cukai>> getTaxFromXML(BuildContext context) async{
    String url = 'http://1.9.129.233/ws/mphtj_cukai_ws.asp?ac='+text;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return parseContacts(response.body); 
    } else {
      throw Exception('Unable to fetch products from the REST API');
    } 
  }

  List<Cukai> parseContacts(String responseBody) {
    var raw = xml.parse(responseBody);
    var elements = raw.findAllElements('mphtj');
        
    return elements.map((element){
      if(element.findElements('reply').first.text == 'SUCCESS'){
        return Cukai(
          element.findElements('nama').first.text, 
          element.findElements('kp').first.text,
          element.findElements('jum').first.text,
          element.findElements('hasil1').first.text,
          element.findElements('hasil2').first.text,
          element.findElements('tkh').first.text,
          element.findElements('akaun').first.text,
          element.findElements('auid').first.text,
          element.findElements('no_tel').first.text,
          element.findElements('no_hp').first.text,
          element.findElements('no_off').first.text,
          element.findElements('emel').first.text,
          element.findElements('hasil_setahun').first.text,
          element.findElements('mukim').first.text,
          element.findElements('mukim1').first.text,
          element.findElements('lotid').first.text,
          element.findElements('seksyen').first.text,
          element.findElements('norumah').first.text,
          element.findElements('jalan').first.text,
          element.findElements('tempat').first.text,
          element.findElements('bandar').first.text
        );
      }else{
        return null;
      }
    }).toList();
  }

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();

  reload() {
      _asyncLoaderState.currentState.reloadState();
  }

  final oCcy = new NumberFormat("#,##0.00", "en_US");
          
  @override
    Widget build(BuildContext context) {
      var _asyncLoader = new AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => getMessage(context),
        renderLoad: () => new CircularProgressIndicator(),
        renderError: ([error]) =>
            new Text('Sorry, there was an error loading'),
        renderSuccess: ({data}) => new Text(data),
      );

      return new WillPopScope(
        onWillPop: () async {return true;},
        child: Scaffold(
          appBar: AppBar(
            title: Text('Data Pengguna'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
                onPressed: () { 
                  Navigator.of(context).pop();
                }
            ),
          ),
          body: Container(
            child: Center(
              child: FutureBuilder(
                future: getTaxFromXML(context),
                builder: (context,data){
                                
                  List<Cukai> contacts = data.data;
                  
                  if(data.hasData && contacts[0] != null){                        
                    return ListView(
                      children: <Widget>[
                        ListTile(
                          dense: true,
                          title: Text('Nama',
                          style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].nama, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('KP', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].kp, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Akaun', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].akaun, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Auid', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].auid, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Tarikh', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].tkh, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('No Tel', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].noTel, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('No HP', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].noHp, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('No Off', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].noOff, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Emel', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].emel, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Amaun', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text('RM ${oCcy.format(double.parse(contacts[0].jum))}', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Hasil Setahun', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text('RM ${oCcy.format(double.parse(contacts[0].hasilSthn))}', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Hasil 1', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text('RM ${oCcy.format(double.parse(contacts[0].hasil1))}', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Hasil 2', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text('RM ${oCcy.format(double.parse(contacts[0].hasil2))}', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Daerah', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].mukim, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Mukim', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].mukim1, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('LotId', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].lotid, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Seksyen', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].seksyen, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('No Rumah', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].noRmh, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Jalan', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].jln, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Tempah', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].tmpt, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Bandar', 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(contacts[0].bndr, 
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Center(
                          child:RaisedButton(
                            onPressed: () { Navigator.of(context).pop();},
                            child: Text('Kembali'),
                          ),
                        ),
                      ],
                    );
                  }else{
                    return Scaffold(
                      body: new Center(
                        child: _asyncLoader,
                      ),
                    );
                  }
                }
              ),
            ),
          ),
        ),
      );
    }
                
    static const TIMEOUT = const Duration(seconds: 3);
                
    getMessage(BuildContext context) async {
      return new Future.delayed(
        TIMEOUT, () => 'Tiada Data');//
    }
}