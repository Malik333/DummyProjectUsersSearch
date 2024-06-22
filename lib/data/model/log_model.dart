import 'package:dummy_project_users_search/data/model/payload_log_model.dart';

import 'actor_log_model.dart';

class LogModel {
  String? id;
  String? createdAt;
  String? type;
  ActorLogModel? actor;
  PayloadLogModel? payload;

  LogModel(
      {this.id,
        this.createdAt,
        this.type,
        this.actor,
        this.payload
        });

  LogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    actor = json['actor'] != null ? ActorLogModel.fromJson(json['actor']) : null;
    payload = json['payload'] != null ? PayloadLogModel.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['created_at'] = createdAt;
    data['type'] = type;
    data['actor'] = actor;
    data['payload'] = payload;
    return data;
  }
}
