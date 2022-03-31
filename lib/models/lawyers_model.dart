class LawyersModel
{
  List<Lawyers> lawyersData = [];

  LawyersModel.fromJson(List json)
  {
    for (var element in json) {
      lawyersData.add(Lawyers.fromjson(element));
    }
  }
}
class Lawyers
{
  int? id;
  String? lawyerNationalNumber;
  String? name;
  String? email;
  DateTime? emailVerifiedAt;
  String? address;
  String? profilePhotoPath;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Lawyers.fromjson(Map<String,dynamic> json)
  {
    id = json['id'];
    lawyerNationalNumber = json['Lawyer_National_Number'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    address = json['address'];
    profilePhotoPath = json['profile_photo_path'];
    role = json['Role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
}

