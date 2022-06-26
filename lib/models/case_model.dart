class CaseModel
{
  String? status;
  String? message;
  List<CaseData>? casesData;

  CaseModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      casesData = <CaseData>[];
      json['data'].forEach((element) {
        casesData!.add(CaseData.fromJson(element));
      });
    }
  }
}

class CaseData
{
  int? id;
  String? caseID;
  String? title;
  String? caseType;
  String? clientName;
  String? contender;
  int? courtNumber;
  String? content;
  String? note;
  String? status;
  int? lawyerID;
  String? createdAt;
  String? updatedAt;
  String? attachments;

  CaseData.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    caseID = json['Case_id'];
    title = json['Title'];
    caseType = json['Case_type'];
    clientName = json['client_name'];
    contender = json['contender'];
    courtNumber = json['Court_no'];
    content = json['Content'];
    note = json['Note'];
    lawyerID = json['Lawyer_id'];
    createdAt =json['created_at'];
    updatedAt =json['updated_at'];
    status = json['status'];
    attachments = json['Attachment'];
  }
}