/// AppStrings contains all the string constants used in the MediBook app.
class AppStrings {
  AppStrings._(); // Private constructor to prevent instantiation

  // General App info
  static const String appName = 'MediBook';
  static const String appTagline = 'Your Health, Our Priority';
  static const String welcomeGreeting = 'Good Morning 👋';

  // Home Screen
  static const String searchHint = 'Search doctors...';
  static const String topDoctors = 'Top Doctors';

  // Categories
  static const List<String> categories = [
    'All',
    'General Physician',
    'Dentist',
    'Cardiologist',
    'Dermatologist',
    'Pediatrician',
    'Orthopedic'
  ];

  // Buttons
  static const String bookNow = 'Book Now';
  static const String bookAppointment = 'Book Appointment';
  static const String confirmAppointment = 'Confirm Appointment';
  static const String cancel = 'Cancel';

  // Details
  static const String aboutDoctor = 'About Doctor';
  static const String qualifications = 'Qualifications';
  static const String consultationFee = 'Consultation Fee';
  static const String availableTimeSlots = 'Available Time Slots';

  // Booking Form
  static const String fullName = 'Full Name';
  static const String phoneNumber = 'Phone Number';
  static const String age = 'Age';
  static const String gender = 'Gender';
  static const String appointmentDate = 'Appointment Date';
  static const String appointmentTime = 'Appointment Time';

  // Appointments Screen
  static const String myAppointments = 'My Appointments';
  static const String upcoming = 'Upcoming';
  static const String past = 'Past';
  static const String noAppointments = 'No appointments yet. Book your first appointment!';

  // Feedback Messages
  static const String selectTimeSlotError = 'Please select a time slot';
  static const String bookingSuccess = 'Appointment Booked Successfully! ✅';
}
