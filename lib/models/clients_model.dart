class ClientsModel {
  String? status;
  String? message;
  List<ClientsData>? clientsData;

  ClientsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      clientsData = <ClientsData>[];
      json['data'].forEach((element) {
        clientsData!.add(ClientsData.fromJson(element));
      });
    }
    else
      {
        clientsData = null;
      }
  }
}


class ClientsData {
  int? id;
  String? clientNationalNumber;
  String? name;
  String? email;
  String? address;
  String? phone;
  int? lawyerId;
  String? createdAt;
  String? updatedAt;


  ClientsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientNationalNumber = json['Client_National_Number'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    lawyerId = json['Lawyer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}