import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/theme_provider.dart';
import 'providers/home_provider.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/category_chip.dart';
import 'widgets/doctor_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctors = ref.watch(doctorListProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.welcomeGreeting, style: AppTextStyles.heading2),
            Text('Find your doctor', style: AppTextStyles.bodyMedium),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              ref.watch(themeModeProvider) == ThemeMode.light
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
            onPressed: () {
              final current = ref.read(themeModeProvider);
              ref.read(themeModeProvider.notifier).state =
                  current == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const SearchBarWidget().animate().fade(duration: 500.ms).slideX(),
              const SizedBox(height: 24),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: AppStrings.categories.length,
                  itemBuilder: (context, index) {
                    return CategoryChip(category: AppStrings.categories[index])
                        .animate().fade(delay: (index * 100).ms);
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text(AppStrings.topDoctors, style: AppTextStyles.heading3)
                  .animate().fade().slideY(),
              const SizedBox(height: 16),
              Expanded(
                child: doctors.isEmpty
                    ? Center(
                        child: Text(
                          'No doctors found',
                          style: AppTextStyles.bodyLarge,
                        ),
                      )
                    : ListView.builder(
                        itemCount: doctors.length,
                        itemBuilder: (context, index) {
                          return DoctorCard(doctor: doctors[index])
                              .animate()
                              .fade(delay: (index * 100).ms)
                              .slideY(begin: 0.2, end: 0);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
