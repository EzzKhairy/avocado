class LawyerModel{
  String? status;
  String? message;
  LawyersList? data;

  LawyerModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    message = json['message'];
    data = LawyersList.fromJson(json['data']);
  }
}
class LawyersList{
  List<LawyerProfile> lawyers = [];

  LawyersList.fromJson(Map<String, dynamic> json)
  {
    json['data'].forEach((element) {
      lawyers.add(LawyerProfile.fromJson(element));
    });
  }
}
class LawyerProfile
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
  String? deletedAt;

  LawyerProfile.fromJson(Map<String,dynamic> json)
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
    deletedAt = json['deleted_at'];
  }
}

