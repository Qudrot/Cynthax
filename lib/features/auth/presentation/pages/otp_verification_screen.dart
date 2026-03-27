import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'profile_setup_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String emailOrPhone;
  const OtpVerificationScreen({super.key, required this.emailOrPhone});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  int _countdown = 30;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() {
      _countdown = 30;
      _canResend = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 0) {
        timer.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _countdown--);
      }
    });
  }

  void _verifyOtp() {
    if (_otpController.text.length == 6) {
      context.read<AuthBloc>().add(VerifyOtpRequested(widget.emailOrPhone, _otpController.text));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 6-digit code')),
      );
    }
  }

  void _resend() {
    if (!_canResend) return;
    context.read<AuthBloc>().add(SendOtpRequested(widget.emailOrPhone));
    _startCountdown();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ProfileSetupScreen()),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.danger),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.professionalWhite,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.corporateSlate),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Shield icon for security perception
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lock_rounded, color: AppColors.primary, size: 36),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Verify Your Identity',
                    style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.corporateSlate),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter the 6-digit code sent to\n${widget.emailOrPhone}',
                    style: GoogleFonts.roboto(fontSize: 15, color: AppColors.textSubtleDark, height: 1.5),
                  ),
                  const SizedBox(height: 40),

                  // OTP Input – large bold digits
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 10,
                      color: AppColors.corporateSlate,
                    ),
                    decoration: InputDecoration(
                      hintText: '------',
                      hintStyle: GoogleFonts.inter(
                        fontSize: 28,
                        letterSpacing: 10,
                        color: AppColors.subtleGrey,
                      ),
                      counterText: '',
                      filled: true,
                      fillColor: AppColors.subtleGrey.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppColors.primary, width: 2),
                      ),
                    ),
                    onChanged: (val) {
                      if (val.length == 6 && state is! AuthLoading) _verifyOtp();
                    },
                  ),

                  const SizedBox(height: 24),

                  // Resend with pulsing Danfo Yellow timer
                  Center(
                    child: _canResend
                        ? TextButton(
                            onPressed: _resend,
                            child: Text(
                              'Resend Code',
                              style: GoogleFonts.inter(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Resend in ",
                                style: GoogleFonts.roboto(color: AppColors.textSubtleDark, fontSize: 14),
                              ),
                              _PulsingText(
                                text: '${_countdown}s',
                                style: GoogleFonts.inter(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                  ),

                  const Spacer(),
                  ElevatedButton(
                    onPressed: state is AuthLoading ? null : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: state is AuthLoading
                        ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text(
                            'Verify',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.professionalWhite),
                          ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PulsingText extends StatefulWidget {
  final String text;
  final TextStyle style;
  const _PulsingText({required this.text, required this.style});

  @override
  State<_PulsingText> createState() => _PulsingTextState();
}

class _PulsingTextState extends State<_PulsingText> with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
      ..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.5, end: 1.0).animate(_pulse);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Text(widget.text, style: widget.style),
    );
  }
}
