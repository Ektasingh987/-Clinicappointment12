import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/models/doctor_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          context.push('/doctor-detail', extra: doctor);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: doctor.imageUrl,
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade300,
                    child: Center(
                      child: Text(
                        doctor.name.substring(4, 6).toUpperCase(), // Get initials roughly
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: AppTextStyles.heading3,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialization,
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.work_outline, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text('${doctor.experience} Years Exp.', style: AppTextStyles.bodySmall),
                        const Spacer(),
                        Icon(Icons.star, size: 16, color: AppColors.accent),
                        const SizedBox(width: 4),
                        Text(doctor.rating.toString(), style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${doctor.consultationFee}',
                          style: AppTextStyles.heading3.copyWith(color: AppColors.primary),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.push('/doctor-detail', extra: doctor);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80, 32),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Text('Book Now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
