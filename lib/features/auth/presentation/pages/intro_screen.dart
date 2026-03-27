import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import 'onboarding_page.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<IntroPageData> _pages = [
    IntroPageData(
      title: 'Ride Smart, Network Smarter.',
      description: 'Connect with working professionals on your daily commute. Turn travel time into productive networking.',
      icon: Icons.people_alt_rounded,
      accentColor: AppColors.primary,
    ),
    IntroPageData(
      title: 'Your Price, Your Ride.',
      description: 'Negotiate fares directly. Propose what you want to pay and find drivers who accept your offer.',
      icon: Icons.price_change_rounded,
      accentColor: AppColors.secondary,
    ),
    IntroPageData(
      title: 'Seamless Journeys, Shared Costs.',
      description: 'Ride alone, or share the cost with up to 3 verified professionals heading your way.',
      icon: Icons.directions_car_filled_rounded,
      accentColor: AppColors.primary,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    } else {
      _navigateToAuth();
    }
  }

  void _navigateToAuth() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const OnboardingPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.professionalWhite,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, top: 8),
                child: TextButton(
                  onPressed: _navigateToAuth,
                  child: Text(
                    'Skip',
                    style: GoogleFonts.roboto(color: AppColors.textSubtleDark, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Illustration Container
                        Container(
                          height: 240,
                          width: 240,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: page.accentColor.withOpacity(0.08),
                            border: Border.all(color: page.accentColor.withOpacity(0.2), width: 1.5),
                          ),
                          child: Icon(
                            page.icon,
                            size: 110,
                            color: page.accentColor,
                          ),
                        ),
                        const SizedBox(height: 56),
                        Text(
                          page.title,
                          style: GoogleFonts.inter(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: AppColors.corporateSlate,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page.description,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: AppColors.textSubtleDark,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 28 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? AppColors.primary : AppColors.subtleGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    )),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentPage == _pages.length - 1 ? AppColors.secondary : AppColors.primary,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.professionalWhite),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroPageData {
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;

  IntroPageData({
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
  });
}
