import 'dart:convert';

class LoginModel
{
  String? status;
  String? message;
  String? accessToken;
  Lawyer? lawyersData;

  LoginModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    accessToken = json['access_token'];
    lawyersData = json['data'] != null ? Lawyer.fromJson(json['data']) : null;
  }
}

class Lawyer
{
  int? id;
  String? status;
  String? lawyerNationalNumber;
  String? name;
  String? email;
  String? profilePhoto;
  String? address;
  String? role;
  String? dateOfBirth;
  String? gender;
  String? createdAt;
  String? updatedAt;

  Lawyer.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    status = json['status'];
    lawyerNationalNumber = json['Lawyer_National_Number'];
    name = json['name'];
    email = json['email'];
    profilePhoto = json['profile_photo_path'];
    address = json['address'];
    role = json['Role'];
    dateOfBirth = json['DOB'];
    gender = json['Gender'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

