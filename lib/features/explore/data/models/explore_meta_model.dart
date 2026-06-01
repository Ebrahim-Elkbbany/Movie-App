class ExploreMetaModel {
  int? apiVersion;
  String? executionTime;

  ExploreMetaModel({this.apiVersion, this.executionTime});

  ExploreMetaModel.fromJson(Map<String, dynamic> json) {
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }
}
