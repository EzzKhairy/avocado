class PaymentsModel
{
  String? status;
  String? message;
  List<PaymentsData>? paymentsData;

  PaymentsModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      paymentsData = <PaymentsData>[];
      json['data'].forEach((element) {
        paymentsData!.add(PaymentsData.fromJson(element));
      });
    }
  }
}

class PaymentsData
{
  int? id;
  String? name;
  String? amount;
  String? note;
  int? caseId;
  String? createdAt;
  String? updatedAt;

  PaymentsData.fromJson(Map<String, dynamic>json)
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