import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../booking/domain/models/appointment_model.dart';

class AppointmentsNotifier extends StateNotifier<List<AppointmentModel>> {
  AppointmentsNotifier() : super([]);

  void addAppointment(AppointmentModel appointment) {
    state = [...state, appointment];
  }

  void cancelAppointment(String id) {
    state = [
      for (final appointment in state)
        if (appointment.id == id)
          appointment.copyWith(status: 'Cancelled')
        else
          appointment,
    ];
  }
}

final appointmentsProvider = StateNotifierProvider<AppointmentsNotifier, List<AppointmentModel>>((ref) {
  return AppointmentsNotifier();
});
