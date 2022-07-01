class LegislationModel {
  String? status;
  String? message;
  List<LegislationsData>? data;

  LegislationModel({this.status, this.message, this.data});

  LegislationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LegislationsData>[];
      json['data'].forEach((v) {
        data!.add(LegislationsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LegislationsData {
  int? id;
  String? name;
  String? attachment;
  int? lawyerId;
  String? createdAt;
  String? updatedAt;

  LegislationsData(
      {this.id,
        this.name,
        this.attachment,
        this.lawyerId,
        this.createdAt,
        this.updatedAt});

  LegislationsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    attachment = json['Attachment'];
    lawyerId = json['Lawyer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['Attachment'] = attachment;
    data['Lawyer_id'] = lawyerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}