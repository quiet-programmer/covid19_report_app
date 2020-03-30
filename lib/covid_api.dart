import 'dart:convert';

import 'package:covid_19_app/models/covid_model.dart';
import 'package:http/http.dart' as http;

class CovidAPI {
  static const API =
      "https://coronavirus-tracker-api.herokuapp.com/v2/locations";
  static const headers = {"Accept": "application/json"};

  List data;

  Future<dynamic> fetchReport() async {
    final response = await http.get(
      API,
      headers: headers,
    );
    var convertDataToJson = json.decode(response.body);
    data = convertDataToJson['locations'];
    // print(data.toString());

    List<CovidModel> reports = List();

    data.forEach((report) {
      String country = report['country'];
      String countryCode = report['country_code'];
      var countryPopulation = report['country_population'];
      String province = report['province'];
      var confirmed = report['latest']['confirmed'];
      var deaths = report['latest']['deaths'];
      var recovered = report['latest']['recovered'];

      reports.add(CovidModel(
        country: country,
        countryCode: countryCode,
        countryPopulation: countryPopulation,
        province: province,
        confirmed: confirmed,
        deaths: deaths,
        recovered: recovered,
      ));

    });
    return reports;
  }
}
