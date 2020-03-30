import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TotalCaseWidget extends StatefulWidget {
  @override
  _TotalCaseWidgetState createState() => _TotalCaseWidgetState();
}

class _TotalCaseWidgetState extends State<TotalCaseWidget> {
  Map allData;
  var getData;
  var confirmed;
  var deaths;
  var recovered;

  bool isLoading = false;
  Future<dynamic> getLastestReport() async {
    setState(() {
      isLoading = true;
    });
    //API for getting the data
    String apiLink = "https://coronavirus-tracker-api.herokuapp.com/v2/latest";

    var res = await http.get(apiLink, headers: {"Accept": "json/application"});

    if (res.statusCode == 200) {
      allData = json.decode(res.body);
      getData = allData['latest'];
      // print(getData.toString());

      confirmed = getData['confirmed'];
      deaths = getData['deaths'];
      recovered = getData['recovered'];

      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    super.initState();
    getLastestReport();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 100,
                    child: Card(
                      color: Color.fromRGBO(153, 204, 255, 1),
                      elevation: 5.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Total Comfirmed Cases: $confirmed",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'serif',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    child: Card(
                      color: Color.fromRGBO(255, 153, 153, 1),
                      elevation: 5.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Total Death Cases: $deaths",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'serif',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    child: Card(
                      elevation: 5.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Total Recovered Cases: $recovered",
                              style: TextStyle(
                                fontFamily: 'serif',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
