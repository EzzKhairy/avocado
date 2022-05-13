class InvestigationModel
{
  String? status;
  String? message;
  List<InvestigationData>? investigationData;

  InvestigationModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      investigationData = <InvestigationData>[];
      json['data'].forEach((element) {
        investigationData!.add(InvestigationData.fromJson(element));
      });
    }
  }
}

class InvestigationData
{
  int? id;
  String? investigationId;
  String? topic;
  String? inDate;
  String? contender;
  int? lawyerId;
  int? caseID;
  String? client;
  int? investigationPlaceNo;
  String? decision;
  String? note;
  String? createdAt;
  String? updatedAt;

  InvestigationData.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    investigationId = json['investigation_id'];
    topic = json['topic'];
    inDate = json['in_Date'];
    contender = json['contender'];
    client = json['client'];
    lawyerId = json['Lawyer_id'];
    caseID = json['Case_id'];
    investigationPlaceNo = json['investigation_place_No'];
    decision = json['Decision'];
    note = json['Note'];
    createdAt =json['created_at'];
    updatedAt =json['updated_at'];
  }
}