class LawyersModel {
  String? status;
  String? message;
  List<LawyerData>? data;

  LawyersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LawyerData>[];
      json['data'].forEach((element) {
        data!.add(LawyerData.fromJson(element));
      });
    }
  }
}


class LawyerData {
  int? id;
  String? lawyerNationalNumber;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? status;
  String? address;
  String? profilePhotoPath;
  String? role;
  String? dateOfBirth;
  String? gender;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;


  LawyerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lawyerNationalNumber = json['Lawyer_National_Number'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    address = json['address'];
    profilePhotoPath = json['profile_photo_path'];
    role = json['Role'];
    dateOfBirth = json['DOB'];
    gender = json['Gender'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Lawyer_National_Number'] = lawyerNationalNumber;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['status'] = status;
    data['address'] = address;
    data['profile_photo_path'] = profilePhotoPath;
    data['Role'] = role;
    data['DOB'] = dateOfBirth;
    data['Gender'] = gender;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}