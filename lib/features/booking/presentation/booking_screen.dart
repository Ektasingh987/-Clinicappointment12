import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../home/domain/models/doctor_model.dart';
import '../../appointments/presentation/providers/appointments_provider.dart';
import '../domain/models/appointment_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> extraData; // contains 'doctor' and 'timeSlot'

  const BookingScreen({super.key, required this.extraData});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _dateController = TextEditingController();
  
  String _selectedGender = 'Male';
  late DoctorModel doctor;
  late String timeSlot;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    doctor = widget.extraData['doctor'] as DoctorModel;
    timeSlot = widget.extraData['timeSlot'] as String;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final appointment = AppointmentModel(
        id: const Uuid().v4(),
        doctorName: doctor.name,
        doctorSpecialization: doctor.specialization,
        doctorImageUrl: doctor.imageUrl,
        patientName: _nameController.text.trim(),
        patientPhone: _phoneController.text.trim(),
        patientAge: int.parse(_ageController.text.trim()),
        patientGender: _selectedGender,
        appointmentDate: _dateController.text,
        appointmentTime: timeSlot,
        consultationFee: doctor.consultationFee,
        status: 'Upcoming',
      );

      ref.read(appointmentsProvider.notifier).addAppointment(appointment);
      
      setState(() => _isLoading = false);

      if (mounted) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: AppColors.success, size: 80),
                const SizedBox(height: 16),
                const Text(AppStrings.bookingSuccess, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                Card(
                  elevation: 0,
                  color: AppColors.backgroundLight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _SummaryRow(label: 'Doctor', value: doctor.name),
                        _SummaryRow(label: 'Specialization', value: doctor.specialization),
                        _SummaryRow(label: 'Date', value: _dateController.text),
                        _SummaryRow(label: 'Time', value: timeSlot),
                        const Divider(),
                        _SummaryRow(label: 'Total Fee', value: '₹${doctor.consultationFee}', valueStyle: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'View Appointments',
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.go('/appointments');
                  },
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: _nameController,
                labelText: AppStrings.fullName,
                prefixIcon: Icons.person_outline,
                validator: Validators.validateName,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _phoneController,
                labelText: AppStrings.phoneNumber,
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: Validators.validatePhone,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _ageController,
                      labelText: AppStrings.age,
                      prefixIcon: Icons.calendar_today_outlined,
                      keyboardType: TextInputType.number,
                      validator: Validators.validateAge,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: InputDecoration(
                        labelText: AppStrings.gender,
                        prefixIcon: const Icon(Icons.people_outline),
                      ),
                      items: ['Male', 'Female', 'Other']
                          .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) setState(() => _selectedGender = value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _dateController,
                labelText: AppStrings.appointmentDate,
                prefixIcon: Icons.calendar_month,
                readOnly: true,
                onTap: _selectDate,
                validator: (val) => Validators.validateRequired(val, 'Date'),
              ),
              const SizedBox(height: 16),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: AppStrings.appointmentTime,
                  prefixIcon: Icon(Icons.access_time),
                ),
                child: Text(timeSlot, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 32),
              
              // Summary Card
              Card(
                color: AppColors.primary.withOpacity(0.05),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.primary.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const Divider(),
                      _SummaryRow(label: 'Doctor', value: doctor.name),
                      _SummaryRow(label: 'Specialization', value: doctor.specialization),
                      _SummaryRow(label: 'Time', value: timeSlot),
                      const Divider(),
                      _SummaryRow(
                        label: 'Total Fee',
                        value: '₹${doctor.consultationFee}',
                        valueStyle: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: AppStrings.confirmAppointment,
                isLoading: _isLoading,
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const _SummaryRow({required this.label, required this.value, this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: valueStyle ?? const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
