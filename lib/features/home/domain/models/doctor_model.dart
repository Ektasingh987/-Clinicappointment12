class DoctorModel {
  final String id;
  final String name;
  final String specialization;
  final int experience;
  final int consultationFee;
  final double rating;
  final String imageUrl;
  final String about;
  final List<String> availableSlots;
  final String qualifications;
  final String hospital;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experience,
    required this.consultationFee,
    required this.rating,
    required this.imageUrl,
    required this.about,
    required this.availableSlots,
    required this.qualifications,
    required this.hospital,
  });
}
