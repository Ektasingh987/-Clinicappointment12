import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../home/domain/models/doctor_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'widgets/time_slot_widget.dart';

class DoctorDetailScreen extends ConsumerStatefulWidget {
  final DoctorModel doctor;

  const DoctorDetailScreen({super.key, required this.doctor});

  @override
  ConsumerState<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends ConsumerState<DoctorDetailScreen> {
  @override
  void dispose() {
    // Safely invalidate without depending on context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(selectedSlotProvider);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedSlot = ref.watch(selectedSlotProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.doctor.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.doctor.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.grey.shade300),
                    errorWidget: (context, url, error) => Container(color: Colors.grey.shade300),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatCard(title: 'Experience', value: '${widget.doctor.experience} yrs', icon: Icons.work_history),
                      _StatCard(title: 'Patients', value: '1K+', icon: Icons.groups),
                      _StatCard(title: 'Rating', value: widget.doctor.rating.toString(), icon: Icons.star, iconColor: AppColors.accent),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(AppStrings.aboutDoctor, style: AppTextStyles.heading2),
                  const SizedBox(height: 8),
                  Text(widget.doctor.about, style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 24),
                  Text(AppStrings.qualifications, style: AppTextStyles.heading2),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(widget.doctor.qualifications, style: const TextStyle(color: Colors.white)),
                    backgroundColor: AppColors.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(AppStrings.consultationFee, style: AppTextStyles.heading2),
                  const SizedBox(height: 8),
                  Text('₹${widget.doctor.consultationFee}', style: AppTextStyles.heading1.copyWith(color: AppColors.primary)),
                  const SizedBox(height: 24),
                  Text(AppStrings.availableTimeSlots, style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.doctor.availableSlots.length,
                      itemBuilder: (context, index) {
                        return TimeSlotWidget(time: widget.doctor.availableSlots[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 100), // padding for bottom button
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            )
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            if (selectedSlot == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.selectTimeSlotError)),
              );
            } else {
              context.push('/booking', extra: {'doctor': widget.doctor, 'timeSlot': selectedSlot});
            }
          },
          child: const Text(AppStrings.bookAppointment),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? iconColor;

  const _StatCard({required this.title, required this.value, required this.icon, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.primary.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Icon(icon, color: iconColor ?? AppColors.primary),
            const SizedBox(height: 8),
            Text(value, style: AppTextStyles.heading3.copyWith(color: AppColors.primary)),
            const SizedBox(height: 4),
            Text(title, style: AppTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}
