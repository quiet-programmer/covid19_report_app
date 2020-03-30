class CovidModel {
  String country;
  String countryCode;
  var countryPopulation;
  String province;
  var confirmed;
  var deaths;
  var recovered;

  CovidModel({
    this.country,
    this.countryCode,
    this.countryPopulation,
    this.province,
    this.confirmed,
    this.deaths,
    this.recovered,
  });
}
