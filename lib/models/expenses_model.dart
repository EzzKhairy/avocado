class ExpensesModel
{
  String? status;
  String? message;
  List<ExpensesData>? expensesData;

  ExpensesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      expensesData = <ExpensesData>[];
      json['data'].forEach((element) {
        expensesData!.add(ExpensesData.fromJson(element));
      });
    }
  }
}

class ExpensesData
{
  int? id;
  String? name;
  String? amount;
  String? note;
  int? caseId;
  String? createdAt;
  String? updatedAt;

  ExpensesData.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    amount = json['Amount'];
    note = json['Note'];
    caseId = json['Case_id'];
    createdAt =json['created_at'];
    updatedAt =json['updated_at'];
  }
}