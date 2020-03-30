import 'package:covid_19_app/covid_api.dart';
import 'package:covid_19_app/widgets/total_case_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CovidAPI _covidAPI = CovidAPI();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Covid 19",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.help_outline,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              TotalCaseWidget(),
              SizedBox(
                height: 10.0,
              ),
              FutureBuilder(
                future: _covidAPI.fetchReport(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return Card(
                            elevation: 5.0,
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Text(
                                    snapshot.data[index].countryCode,
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  title: Text(
                                    snapshot.data[index].country,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'serif'),
                                  ),
                                  subtitle: Text(
                                    "Country Population: ${snapshot.data[index].countryPopulation}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'serif',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Could not fetch data"),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
