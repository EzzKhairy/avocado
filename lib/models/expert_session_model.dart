class ExpertSessionModel
{
  String? status;
  String? message;
  List<ExpertSessionData>? expertSessionData;

  ExpertSessionModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      expertSessionData = <ExpertSessionData>[];
      json['data'].forEach((element) {
        expertSessionData!.add(ExpertSessionData.fromJson(element));
      });
    }
  }
}

class ExpertSessionData
{
  int? id;
  String? presentLawyerName;
  String? expertName;
  String? sessionReason;
  String? sessionDate;
  String? officeAddress;
  String? attachment;
  String? decision;
  String? nextDate;
  int? caseId;
  String? createdAt;
  String? updatedAt;

  ExpertSessionData.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    presentLawyerName = json['present_Lawyer_name'];
    expertName = json['Expert_name'];
    sessionReason = json['Session_Reason'];
    sessionDate = json['Session_date'];
    officeAddress = json['Office_address'];
    attachment = json['Attachment'];
    decision = json['Desicion'];
    nextDate = json['Next_date'];
    caseId = json['Case_id'];
    createdAt =json['created_at'];
    updatedAt =json['updated_at'];
  }
}