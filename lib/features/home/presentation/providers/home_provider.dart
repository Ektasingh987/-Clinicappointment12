import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/doctor_model.dart';
import '../../data/doctor_data.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => 'All');
final searchQueryProvider = StateProvider<String>((ref) => '');

class DoctorListNotifier extends StateNotifier<List<DoctorModel>> {
  DoctorListNotifier() : super(DoctorData.doctors);

  void filter(String category, String query) {
    List<DoctorModel> filtered = DoctorData.doctors;
    
    if (category != 'All') {
      filtered = filtered.where((doc) => doc.specialization == category).toList();
    }
    
    if (query.trim().isNotEmpty) {
      filtered = filtered.where((doc) => 
        doc.name.toLowerCase().contains(query.toLowerCase()) ||
        doc.specialization.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    
    state = filtered;
  }
}

final doctorListProvider = StateNotifierProvider<DoctorListNotifier, List<DoctorModel>>((ref) {
  final notifier = DoctorListNotifier();
  
  ref.listen<String>(selectedCategoryProvider, (previous, next) {
    notifier.filter(next, ref.read(searchQueryProvider));
  });
  
  ref.listen<String>(searchQueryProvider, (previous, next) {
    notifier.filter(ref.read(selectedCategoryProvider), next);
  });
  
  return notifier;
});
