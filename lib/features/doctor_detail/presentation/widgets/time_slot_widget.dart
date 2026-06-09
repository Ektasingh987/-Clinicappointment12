import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';

final selectedSlotProvider = StateProvider.autoDispose<String?>((ref) => null);

class TimeSlotWidget extends ConsumerWidget {
  final String time;

  const TimeSlotWidget({super.key, required this.time});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSlot = ref.watch(selectedSlotProvider);
    final isSelected = selectedSlot == time;

    return GestureDetector(
      onTap: () {
        ref.read(selectedSlotProvider.notifier).state = time;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade400,
          ),
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
