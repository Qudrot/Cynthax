import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../../domain/models/user_model.dart';
import '../../../home/presentation/pages/passenger_home_screen.dart';
import '../../../home/presentation/pages/driver_home_screen.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600));
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );
    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.elasticOut)),
    );
    _controller.forward();
  }

  void _navigateToNext(AuthState state) {
    if (!mounted) return;
    Widget nextScreen;
    if (state is AuthAuthenticated) {
      nextScreen = state.user.role == UserRole.driver
          ? const DriverHomeScreen()
          : const PassengerHomeScreen();
    } else {
      nextScreen = const IntroScreen();
    }
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => nextScreen,
        transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated || state is AuthUnauthenticated) {
          Future.delayed(const Duration(seconds: 2), () => _navigateToNext(state));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary, // Lagos Electric Blue background
        body: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Danfo Yellow Logo Container
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.directions_car_rounded,
                        size: 64,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'NextStop',
                    style: GoogleFonts.inter(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: AppColors.professionalWhite,
                      letterSpacing: -1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your Professional Commute, Reimagined.',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: AppColors.professionalWhite.withOpacity(0.75),
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
