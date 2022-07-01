class ModelsModel {
  String? status;
  String? message;
  List<ModelsData>? data;

  ModelsModel({this.status, this.message, this.data});

  ModelsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ModelsData>[];
      json['data'].forEach((v) {
        data!.add( ModelsData.fromJson(v));
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

class ModelsData {
  int? id;
  String? name;
  String? attachment;
  int? lawyerId;
  String? createdAt;
  String? updatedAt;

  ModelsData(
      {this.id,
        this.name,
        this.attachment,
        this.lawyerId,
        this.createdAt,
        this.updatedAt});

  ModelsData.fromJson(Map<String, dynamic> json) {
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