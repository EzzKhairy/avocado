class CourtModel {
  String? status;
  String? message;
  List<CourtData>? courtData;

  CourtModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      courtData = <CourtData>[];
      json['data'].forEach((element) {
        courtData!.add(CourtData.fromJson(element));
      });
    }
    else
    {
      courtData = null;
    }
  }
}


class CourtData {
  int? id;
  String? name;
  String? address;
  dynamic longitude;
  dynamic latitude;
  String? phone;
  String? createdAt;
  String? updatedAt;


  CourtData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    longitude = json['Longtude'];
    latitude = json['Latitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}