import 'explore_data_model.dart';
import 'explore_meta_model.dart';

class ExploreMoviesModel {
  String? status;
  String? statusMessage;
  ExploreDataModel? data;
  ExploreMetaModel? meta;

  ExploreMoviesModel({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  ExploreMoviesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? ExploreDataModel.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? ExploreMetaModel.fromJson(json['@meta']) : null;
  }
}
