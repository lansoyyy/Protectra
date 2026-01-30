import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/pairing/pairing_screen.dart';
import 'features/main/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protectra',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashWrapper(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/pairing': (context) => const PairingScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}

/// Wrapper to handle splash screen and initial navigation
class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  bool _showSplash = true;
  bool _hasCompletedOnboarding =
      false; // In real app, load from SharedPreferences

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    // Simulate checking onboarding status
    await Future.delayed(const Duration(milliseconds: 100));

    // In real app, check SharedPreferences or other storage
    // final prefs = await SharedPreferences.getInstance();
    // _hasCompletedOnboarding = prefs.getBool('onboarding_completed') ?? false;

    // For demo purposes, set to false to show onboarding
    _hasCompletedOnboarding = false;
  }

  void _onSplashComplete() {
    setState(() {
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return SplashScreen(onComplete: _onSplashComplete);
    }

    return _hasCompletedOnboarding
        ? const MainScreen()
        : const OnboardingScreen();
  }
}
