class EmployeesListResModel {
  int? status;
  String? message;
  List<EmployeeDetails>? employeeList;

  EmployeesListResModel({
    this.status,
    this.message,
    this.employeeList,
  });

  factory EmployeesListResModel.fromJson(Map<String, dynamic> json) =>
      EmployeesListResModel(
        status: json["status"],
        message: json["message"],
        employeeList: json["data"] == null
            ? []
            : List<EmployeeDetails>.from(
                json["data"]!.map((x) => EmployeeDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": employeeList == null
            ? []
            : List<dynamic>.from(employeeList!.map((x) => x.toJson())),
      };
}

class EmployeeDetails {
  int? id;
  String? name;
  String? role;

  EmployeeDetails({
    this.id,
    this.name,
    this.role,
  });

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) =>
      EmployeeDetails(
        id: json["id"],
        name: json["name"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": role,
      };
}
