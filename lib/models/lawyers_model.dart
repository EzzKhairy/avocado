class LawyersModel
{
  List<Lawyers> lawyersData = [];
  LawyersModel.fromJson(Map<String,dynamic> json)
  {
    json['data'].forEach((element)
    {
      lawyersData.add(Lawyers.fromJson(element));
    });
  }
}
class Lawyers
{
  int? id;
  String? lawyerNationalNumber;
  String? name;
  String? email;
  String? address;
  String? role;
  String? createdAt;
  String? updatedAt;

  Lawyers.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    lawyerNationalNumber = json['Lawyer_National_Number'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    role = json['Role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

