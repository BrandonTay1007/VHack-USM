import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import '../widgets/menu_option.dart';
import 'settings_screen.dart';
import 'forum/forum_provider.dart';
import 'forum/forum_page.dart';
import 'symptom_tracker/symptom_tracker_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSettings = false;

  void _navigateToForum() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => ForumProvider(),
          child: const ForumPage(),
        ),
      ),
    );
  }

  void _navigateToSymptomChecker() {
    // TODO: Navigate to VHackUSM disease page
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const DiseasePage(),
    //   ),
    // );
  }

  void _navigateToSymptomTracker() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SymptomTrackerPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image covering the entire screen
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Header with logo and settings
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Settings icon
                      IconButton(
                        icon: const Icon(Icons.settings, size: 28, color: Color(0xFF333333)),
                        onPressed: () {
                          setState(() {
                            showSettings = true;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Medium-sized logo above the buttons
                  Image.asset(
                    'assets/images/logo.png',
                    height: 300,
                  ),
                  const SizedBox(height: 30),
                  // Menu options with animation
                  Expanded(
                    child: Column(
                      children: [
                        BounceInDown(
                          duration: const Duration(milliseconds: 600),
                          child: MenuOption(
                            title: 'SYMPTOM CHECKER',
                            backgroundColor: const Color(0xFFC5A8FF),
                            onTap: _navigateToSymptomChecker,
                          ),
                        ),
                        const SizedBox(height: 20),
                        BounceInDown(
                          duration: const Duration(milliseconds: 800),
                          child: MenuOption(
                            title: 'MEDICAL FORUM',
                            backgroundColor: const Color(0xFFB4E4BE),
                            onTap: _navigateToForum,
                          ),
                        ),
                        const SizedBox(height: 20),
                        BounceInDown(
                          duration: const Duration(milliseconds: 1000),
                          child: MenuOption(
                            title: 'CLINIC FINDER',
                            backgroundColor: const Color(0xFFA7D8F5),
                            onTap: () {
                              // TODO: Add clinic finder navigation
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        BounceInDown(
                          duration: const Duration(milliseconds: 1200),
                          child: MenuOption(
                            title: 'SYMPTOM TRACKER',
                            backgroundColor: const Color(0xFFF5A7D8),
                            onTap: _navigateToSymptomTracker,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Sliding Settings Screen
          if (showSettings)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              bottom: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.6,
              child: SettingsScreen(
                onClose: () {
                  setState(() {
                    showSettings = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
