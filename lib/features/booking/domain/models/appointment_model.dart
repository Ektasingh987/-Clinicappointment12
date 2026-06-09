class AppointmentModel {
  final String id;
  final String doctorName;
  final String doctorSpecialization;
  final String doctorImageUrl;
  final String patientName;
  final String patientPhone;
  final int patientAge;
  final String patientGender;
  final String appointmentDate;
  final String appointmentTime;
  final int consultationFee;
  final String status; // "Upcoming" / "Completed" / "Cancelled"

  const AppointmentModel({
    required this.id,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.doctorImageUrl,
    required this.patientName,
    required this.patientPhone,
    required this.patientAge,
    required this.patientGender,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.consultationFee,
    required this.status,
  });

  AppointmentModel copyWith({
    String? status,
  }) {
    return AppointmentModel(
      id: id,
      doctorName: doctorName,
      doctorSpecialization: doctorSpecialization,
      doctorImageUrl: doctorImageUrl,
      patientName: patientName,
      patientPhone: patientPhone,
      patientAge: patientAge,
      patientGender: patientGender,
      appointmentDate: appointmentDate,
      appointmentTime: appointmentTime,
      consultationFee: consultationFee,
      status: status ?? this.status,
    );
  }
}
