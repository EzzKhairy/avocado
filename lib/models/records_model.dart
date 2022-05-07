class RecordsModel
{
  String? status;
  String? message;
  List<RecordsData>? recordsData;

  RecordsModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      recordsData = <RecordsData>[];
      json['data'].forEach((element) {
        recordsData!.add(RecordsData.fromJson(element));
      });
    }
  }
}

class RecordsData
{
  int? id;
  String? recordId;
  String? topic;
  String? attachment;
  String? note;
  String? clientName;
  String? contender;
  int? lawyerId;
  String? createdAt;
  String? updatedAt;

  RecordsData.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    recordId = json['record_id'];
    topic = json['topic'];
    attachment = json['Attachment'];
    note = json['Note'];
    clientName = json['Client_name'];
    contender = json['Contender'];
    lawyerId = json['Lawyer_id'];
    createdAt =json['created_at'];
    updatedAt =json['updated_at'];
  }
}