class TasksModel {
  String? status;
  String? message;
  List<TasksData>? tasksData;

  TasksModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      tasksData = <TasksData>[];
      json['data'].forEach((element) {
        tasksData!.add(TasksData.fromJson(element));
      });
    }
    else
    {
      tasksData = null;
    }
  }
}


class TasksData {
  int? id;
  String? title;
  String? date;
  String? startTime;
  String? endTime;
  String? description;
  String? createdAt;
  String? updatedAt;


  TasksData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['Title'];
    date = json['Date'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    description = json['Description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}