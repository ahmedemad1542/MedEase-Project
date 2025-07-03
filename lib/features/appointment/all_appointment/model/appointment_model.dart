class AppointmentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorName;
  final String doctorId;
  final String appointmentId;

  final String priority;
  final DateTime appointmentDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorName,
    required this.doctorId,
    required this.priority,
    required this.appointmentDate,
    required this.createdAt,
    required this.updatedAt,
    required this.appointmentId,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['_id'] ?? '',
      patientId: json["patientId"]['_id'] ?? '',
      patientName: json['patientName'] ?? '',
      doctorName: json['doctorName'] ?? '',
      doctorId: json['doctorId']['_id'] ?? "",
      priority: json['priority'] ?? '',
      appointmentDate: DateTime.parse(json['appointmentDate'] ?? ''),
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
      appointmentId: json['appointmentId'] ?? '',
    );
  }
}
