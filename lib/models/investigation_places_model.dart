class InvestigationPlacesModel {
  String? status;
  String? message;
  List<InvestigationPlacesData>? data;


  InvestigationPlacesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <InvestigationPlacesData>[];
      json['data'].forEach((v) {
        data!.add(new InvestigationPlacesData.fromJson(v));
      });
    }
  }
}

class InvestigationPlacesData {
  int? id;
  String? name;
  String? address;
  String? createdAt;
  String? updatedAt;


  InvestigationPlacesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}