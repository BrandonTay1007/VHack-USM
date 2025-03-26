import 'package:flutter/material.dart';
import 'package:medease_app/screens/home_screen.dart';
import 'package:medease_app/screens/welcome_screen.dart';
import 'package:medease_app/screens/signorlog.dart';
import 'package:medease_app/screens/signup_screen.dart';
import 'package:medease_app/screens/login_screen.dart';
import 'package:medease_app/screens/forgot_password_screen.dart';
import 'package:medease_app/screens/reset_password_screen.dart';
import 'package:medease_app/screens/profile_setup_screen.dart';
import 'package:medease_app/screens/profile_screen.dart';
import 'package:medease_app/screens/edit_profile_screen.dart';
import 'package:medease_app/screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedEase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Start with WelcomeScreen
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/signorlog': (context) => const SignOrLogScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/profile_setup': (context) => const ProfileSetupScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => SettingsScreen(
          onClose: () => Navigator.pop(context), 
        ),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/profile':
            if (settings.arguments is Map<String, dynamic>) {
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  username: args['username'] ?? 'Guest',
                  age: args['age'] ?? '',
                  gender: args['gender'] ?? '',
                  profileImage: args['profileImage'],
                ),
              );
            }
            break;

          case '/settings':
            return MaterialPageRoute(
              builder: (context) => SettingsScreen(
                 onClose: () => Navigator.pop(context),  // Ensure closing behavior
              ),
            );

          default:
            return null; // If no route matches, return null
        }
        return null;
      },
    );
  }
}
