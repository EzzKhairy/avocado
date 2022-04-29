class SessionModel
{
  String? status;
  String? message;
  List<SessionData>? sessionData;

  SessionModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      sessionData = <SessionData>[];
      json['data'].forEach((element) {
        sessionData!.add(SessionData.fromJson(element));
      });
    }
  }
}

class SessionData
{
  int? id;
  int? roleNumber;
  String? presentLawyerName;
  String? sessionReason;
  String? sessionDate;
  String? sessionRequirements;
  String? attachment;
  String? decision;
  String? nextDate;
  int? caseId;
  String? createdAt;
  String? updatedAt;

  SessionData.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    roleNumber = json['Role_no'];
    presentLawyerName = json['present_Lawyer_name'];
    sessionReason = json['Session_Reason'];
    sessionDate = json['Session_date'];
    sessionRequirements = json['Session_Requirements'];
    attachment = json['Attachment'];
    decision = json['Desicion'];
    nextDate = json['Next_date'];
    caseId = json['Case_id'];
    createdAt =json['created_at'];
    updatedAt =json['updated_at'];
  }
}