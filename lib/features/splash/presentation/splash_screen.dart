import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.splashGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_hospital_rounded,
              size: 100,
              color: Colors.white,
            ).animate()
              .fade(duration: 1000.ms)
              .scale(duration: 1000.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 24),
            Text(
              AppStrings.appName,
              style: AppTextStyles.heading1.copyWith(
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ).animate()
              .fade(delay: 500.ms, duration: 800.ms)
              .slideY(begin: 0.5, end: 0, duration: 800.ms),
            const SizedBox(height: 8),
            Text(
              AppStrings.appTagline,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white70,
              ),
            ).animate()
              .fade(delay: 1000.ms, duration: 800.ms),
          ],
        ),
      ),
    );
  }
}
