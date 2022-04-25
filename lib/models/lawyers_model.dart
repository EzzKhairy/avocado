import 'dart:convert';

class LawyersModel
{
  String? status;
  String? message;
  String? accessToken;
  Lawyers? lawyersData;

  LawyersModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    accessToken = json['access_token'];
    lawyersData =json['data'] != null ? Lawyers.fromJson(json['data']): null;
  }
}
class Lawyers
{
  int? id;
  String? status;
  String? lawyerNationalNumber;
  String? name;
  String? email;
  String? profilePhoto;
  String? address;
  String? role;
  String? createdAt;
  String? updatedAt;

  Lawyers.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    status = json['status'];
    lawyerNationalNumber = json['Lawyer_National_Number'];
    name = json['name'];
    email = json['email'];
    profilePhoto = json['profile_photo_path'];
    address = json['address'];
    role = json['Role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

